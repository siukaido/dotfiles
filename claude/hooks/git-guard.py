#!/usr/bin/env python3
"""Claude Code の PreToolUse hook（matcher: Bash）。人がやると決めている git / gh の操作を止める。

いつも止めるもの（設定が無くても）
- `gh pr merge`
- `git branch -D`（`--delete --force` も。`-d` は通す）

設定ファイルで足すもの（`~/.claude/hooks/git-guard.local.json`。マシンごとに置き、リポジトリには入れない）
- `user_only_paths`: 作業ディレクトリがこの正規表現に合うリポジトリでは、
  `git commit`・`git push`・`gh pr create`・`gh api` での PR の作成を止める
- `user_only_remotes`: `gh ... --repo OWNER/REPO` や `gh api repos/OWNER/REPO/pulls` で
  この正規表現に合うリポジトリを指したら、PR の作成を止める
- `read_only_paths`: 作業ディレクトリがこの正規表現に合うリポジトリでは、
  作業ツリーや履歴を変える git の操作（commit・push・pull・checkout・switch・reset など）を止める
- 正規表現は、作業ディレクトリの絶対パスの末尾に `/` を付けた文字列に当てる

設定の例:
  {
    "user_only_paths": ["/example-app(--[^/]*)?/"],
    "user_only_remotes": ["example-org/example-app\\\\b"],
    "read_only_paths": ["/example-docs/"]
  }

コマンドの文字列だけを見るので、別の道（MCP の GitHub ツールなど）は止められない。
うっかりを防ぐためのもので、わざと抜けるのを防ぐものではない。

単体で試す: echo '{"tool_name":"Bash","tool_input":{"command":"git push"},"cwd":"…"}' | git-guard.py
"""

import json
import os
import re
import shlex
import sys

HOME = os.path.expanduser("~")
CONFIG_PATH = os.path.join(HOME, ".claude", "hooks", "git-guard.local.json")

# git の全体のオプションのうち、値を 1 つとるもの
GIT_OPTS_WITH_VALUE = {"-C", "-c", "--git-dir", "--work-tree", "--namespace", "--exec-path"}
READ_ONLY_BLOCKED = {"commit", "push", "add", "rm", "mv", "reset", "checkout", "switch", "stash",
                     "rebase", "merge", "pull", "restore", "clean", "cherry-pick", "revert", "am", "apply", "tag"}

REASON_USER = "{what} はユーザーがやる決まりです。実行せず、変更と下書き（コミット文・PR の文面）を渡してください。"
REASON_READ_ONLY = "このリポジトリは読むだけの決まりです。{what} は実行しないでください。"
REASON_BRANCH_D = "ブランチは `git branch -d` だけで消す決まりです（`-D` は使わない）。マージされていないなら、消さずにユーザーに伝えてください。"
REASON_MERGE = "PR のマージはユーザーがやる決まりです。実行しないでください。"


def load_config():
    """設定ファイルの正規表現を読む。無い・読めないときは空（いつも止めるものだけになる）"""
    try:
        with open(CONFIG_PATH, encoding="utf-8") as f:
            raw = json.load(f)
    except (OSError, ValueError):
        raw = {}

    def compile_all(key):
        return [re.compile(p) for p in raw.get(key, []) if isinstance(p, str)]

    return {
        "user_only_paths": compile_all("user_only_paths"),
        "user_only_remotes": compile_all("user_only_remotes"),
        "read_only_paths": compile_all("read_only_paths"),
    }


def matches(patterns, text):
    return any(p.search(text) for p in patterns)


def split_segments(command):
    """&&・||・;・|・改行で区切った、コマンドの並び"""
    return [s.strip() for s in re.split(r"&&|\|\||;|\||\n", command) if s.strip()]


def tokenize(segment):
    try:
        return shlex.split(segment)
    except ValueError:
        return segment.split()


def resolve(path, cwd):
    path = os.path.expanduser(path)
    return os.path.normpath(path if os.path.isabs(path) else os.path.join(cwd, path))


def find_program(tokens, name):
    """tokens の中で、name（または …/name）のコマンドが始まる位置。無ければ -1"""
    for i, token in enumerate(tokens):
        if token == name or token.endswith("/" + name):
            return i
    return -1


def git_call(tokens, cwd):
    """git の呼び出しなら (作業ディレクトリ, サブコマンド, 残りの引数)。違えば None"""
    i = find_program(tokens, "git")
    if i < 0:
        return None
    j = i + 1
    while j < len(tokens) and tokens[j].startswith("-"):
        option = tokens[j]
        if option == "-C" and j + 1 < len(tokens):
            cwd = resolve(tokens[j + 1], cwd)
        j += 2 if option in GIT_OPTS_WITH_VALUE else 1
    if j >= len(tokens):
        return None
    return cwd, tokens[j], tokens[j + 1:]


def gh_call(tokens):
    """gh の呼び出しなら、gh より後の引数。違えば None"""
    i = find_program(tokens, "gh")
    return None if i < 0 else tokens[i + 1:]


def is_force_delete(args):
    if any(re.fullmatch(r"-[a-zA-Z]*D[a-zA-Z]*", a) for a in args):
        return True
    deleting = "--delete" in args or any(re.fullmatch(r"-[a-zA-Z]*d[a-zA-Z]*", a) for a in args)
    forced = "-f" in args or "--force" in args
    return deleting and forced


def is_pr_create_api(args):
    """gh api で PR を作る呼び出し（POST で …/pulls）"""
    if not args or args[0] != "api":
        return False
    path = next((a for a in args[1:] if not a.startswith("-") and "pulls" in a), "")
    if not re.search(r"/pulls/?$", path):
        return False
    has_fields = any(a in ("-f", "-F", "--field", "--raw-field", "--input") for a in args)
    return bool(re.search(r"(-X|--method)\s*=?\s*POST", " ".join(args), re.I)) or has_fields


def names_repo(args):
    """gh の引数で、リポジトリを明示しているか（--repo・-R・gh api の repos/…）"""
    return "--repo" in args or "-R" in args or any(a.startswith("--repo=") for a in args) or (
        bool(args) and args[0] == "api")


def check_segment(tokens, cwd, config):
    """止める理由（止めないなら None）と、このあとの作業ディレクトリ"""
    if tokens and tokens[0] == "cd":
        target = tokens[1] if len(tokens) > 1 else HOME
        return None, resolve(target, cwd)

    git = git_call(tokens, cwd)
    if git:
        git_cwd, sub, args = git
        path = git_cwd + "/"
        if sub == "branch" and is_force_delete(args):
            return REASON_BRANCH_D, cwd
        if matches(config["read_only_paths"], path) and sub in READ_ONLY_BLOCKED:
            return REASON_READ_ONLY.format(what=f"`git {sub}`"), cwd
        if matches(config["user_only_paths"], path) and sub in ("commit", "push"):
            return REASON_USER.format(what=f"このリポジトリの `git {sub}`"), cwd
        return None, cwd

    gh = gh_call(tokens)
    if gh is not None:
        if gh[:2] == ["pr", "merge"]:
            return REASON_MERGE, cwd
        if gh[:2] == ["pr", "create"] or is_pr_create_api(gh):
            if matches(config["user_only_remotes"], " ".join(gh)):
                return REASON_USER.format(what="このリポジトリの PR の作成"), cwd
            if not names_repo(gh) and matches(config["user_only_paths"], cwd + "/"):
                return REASON_USER.format(what="このリポジトリの PR の作成"), cwd
    return None, cwd


def check(command, cwd, config):
    for segment in split_segments(command):
        reason, cwd = check_segment(tokenize(segment), cwd, config)
        if reason:
            return reason
    return None


def main():
    data = json.load(sys.stdin)
    if data.get("tool_name") != "Bash":
        return
    command = (data.get("tool_input") or {}).get("command") or ""
    cwd = data.get("cwd") or os.getcwd()
    reason = check(command, cwd, load_config())
    if reason:
        print(json.dumps({"hookSpecificOutput": {
            "hookEventName": "PreToolUse",
            "permissionDecision": "deny",
            "permissionDecisionReason": reason,
        }}, ensure_ascii=False))


if __name__ == "__main__":
    main()
