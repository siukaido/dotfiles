# Claude Code の hook

`~/.claude/settings.json`（このリポジトリの `claude/settings.json`）の `hooks` から呼ぶスクリプト。

- settings.json は厳密な JSON でコメントを書けないので、各 hook の意味はここに書く
- `install.sh` が `~/.claude/hooks/` にファイルごとのリンクを張る
- settings.json の `command` は `~/.claude/hooks/<ファイル名>` を指す
- スクリプトが無いマシンでは、hook はエラーを表示するだけで止まらない（Claude Code の仕様）
  - git-guard が黙って効かなくなるので、新しいマシンでは `install.sh` を流す
- どれも Python 3 だけで動く（追加のパッケージは要らない）

## 一覧

| ファイル | イベント（matcher） | すること |
|---|---|---|
| `japanese-guard.py` | `Stop`、`PreToolUse`（`mcp__.*__wrap_up`） | 応答の本文が英語主体なら、日本語で書き直させる |
| `git-guard.py` | `PreToolUse`（`Bash`） | ユーザーがやると決めた git / gh の操作を止める |

## japanese-guard.py

- ターンの終わりに本文の英字と日本語の文字数を数え、英字が日本語の 3 倍を超えたら終了を止めて書き直させる
  - 差し戻しは 1 ターンに 1 回まで
  - コードブロック・インラインコード・URL・Markdown のリンクは数えない（英語のコミット文の下書きは差し戻されない）
- デスクトップアプリの「次の一手」の箱（`wrap_up`）も、英語なら画面に出る前に止める
- 外への通信もファイルの書き込みもしない（読むのは hook の入力と会話の記録だけ）
- 出どころ: https://github.com/minorun365/claude-code-japanese-guard
  - 取り込んだコミット: `4434ef4b65f87959a3d0fb0dd8ed584bcfe3cc1c`（2026-11-27。中身を読んでから取り込んだ）
  - ライセンス: Apache License 2.0（Copyright 2026 Minoru Onda）
  - 更新するときは、取り込む前に差分を読む
- 環境変数で閾値を変えられる（`JAPANESE_GUARD_RATIO` など。元のリポジトリの README を見る）
  - `JAPANESE_GUARD_DISABLE=1` で無効にできる（`claude -p` で人が読まない出力を作るとき）

## git-guard.py

- いつも止めるもの（設定が無くても）
  - `gh pr merge`
  - `git branch -D`（`--delete --force` も。`-d` は通す）
- マシンごとの設定ファイル `~/.claude/hooks/git-guard.local.json` で、止めるリポジトリを足す
  - このリポジトリには入れない（仕事のリポジトリ名などを公開しないため）
  - 無いときは、いつも止めるものだけになる

| キー | 合ったら止めるもの |
|---|---|
| `user_only_paths` | 作業ディレクトリが合うリポジトリの `git commit`・`git push`・`gh pr create`・`gh api` での PR の作成 |
| `user_only_remotes` | `gh pr create --repo OWNER/REPO` や `gh api repos/OWNER/REPO/pulls` で、合うリポジトリを指した PR の作成 |
| `read_only_paths` | 作業ディレクトリが合うリポジトリで、作業ツリーや履歴を変える git の操作（commit・push・pull・checkout・switch・reset など） |

- 値は正規表現の配列
  - `*_paths` は、作業ディレクトリの絶対パスの末尾に `/` を付けた文字列に当てる
- 設定の例:

```json
{
  "user_only_paths": ["/example-app(--[^/]*)?/"],
  "user_only_remotes": ["example-org/example-app\\b"],
  "read_only_paths": ["/example-docs/"]
}
```

- 通すもの: どれにも合わないリポジトリの操作、`gh pr edit`、`git branch -d`、`git fetch`・`switch`・`merge --ff-only`、読むだけの `gh`
- 作業ディレクトリは hook の入力の `cwd` から始め、`cd X && …` と `git -C X` を追う
- 止めたときは理由を返すので、Claude は実行をやめて下書きを渡す流れに戻る
- コマンドの文字列だけを見るので、MCP の GitHub ツールなど別の道は止められない（うっかりを防ぐためのもの）
- 単体で試す:

```sh
echo '{"tool_name":"Bash","tool_input":{"command":"git push"},"cwd":"'"$PWD"'"}' | ~/.claude/hooks/git-guard.py
```
