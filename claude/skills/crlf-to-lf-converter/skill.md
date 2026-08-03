---
name: convert-crlf
description: CRLF（Windows改行）を LF（Unix改行）に変換するスキル。プロジェクト内のファイルの改行コードを統一する際に使用。
argument-hint: "<target_path> [--dry-run]"
---

# CRLF to LF Converter

## 概要

CRLF（Windows改行：`\r\n`）を LF（Unix改行：`\n`）に変換するスキル。プロジェクト内のファイルの改行コードを統一し、Git での差分を防ぐ。

## 使用タイミング

- 「プロジェクト内の CRLF ファイルを検出して LF に変換して」
- 「改行コードを統一して」
- 「CRLF ファイルを検出してレポートして」
- 「Markdown ファイルの改行を LF に統一して」

## 入力パラメータ

| パラメータ | 説明 | 例 |
|-----------|------|-----|
| `target_path` | 対象ディレクトリまたはファイル | `~/work/myproject/docs/` |

### オプション

| オプション | 説明 | デフォルト |
|-----------|------|----------|
| `--dry-run` | 検出のみ（変換しない） | `false` |
| `--file-pattern` | 対象ファイルパターン | `*.md` |
| `--exclude` | 除外ディレクトリ | `node_modules,.git` |

## 実行手順

### Step 1: CRLF ファイルの検出

指定パス以下の CRLF ファイルを検出:

```bash
# 検出
find <target_path> -type f -name "*.md" -exec file {} \; | grep CRLF
```

**検出情報:**
1. **ファイルパス**: CRLF を含むファイルの絶対パス
2. **ファイル数**: 検出されたファイルの総数

### Step 2: 検出レポートの生成

検出結果を整理してレポートを生成:

```markdown
# CRLF 検出レポート

> **実行日時**: 2026-02-04 16:50:00
> **対象**: ~/work/myproject/docs/
> **検出数**: 12ファイル

## 検出ファイル一覧

1. ~/work/myproject/docs/README.md
2. ~/work/myproject/docs/hoge.md
3. ~/work/myproject/docs/fuga.md
...

## 推奨アクション

全ファイルを LF に変換:
```bash
/convert-crlf ~/work/myproject/docs/
```

個別ファイルのみ変換:
```bash
sed -i '' 's/\r$//' <file_path>
```
```

### Step 3: LF への変換（--dry-run でない場合）

各ファイルを LF に変換:

```bash
# Mac/Linux
sed -i '' 's/\r$//' <file_path>

# Linux（バックアップなし）
sed -i 's/\r$//' <file_path>
```

**処理内容:**
1. **バックアップ不要**: `sed -i ''` でバックアップを作成せずに上書き
2. **CRLF → LF**: 行末の `\r`（CR）を削除
3. **変換確認**: `file` コマンドで変換後の改行コードを確認

### Step 4: 変換結果の確認

変換後のファイルを確認:

```bash
# 変換確認
file <file_path> | grep -v CRLF && echo "OK: LF に変換済み"
```

**確認項目:**
- `CRLF` が含まれていないこと
- `ASCII text` または `UTF-8 Unicode text` として認識されること

### Step 5: 変換サマリの出力

変換結果をサマリとして出力:

```
✅ hoge.md (CRLF → LF)
✅ fuga.md (CRLF → LF)
✅ piyo.md (CRLF → LF)

合計: 3ファイル変換完了
```

## 出力フォーマット

### dry-run モード（検出のみ）

```
🔍 CRLF 検出レポート

対象: ~/work/myproject/docs/
検出: 12ファイル

📄 検出ファイル:
1. ~/work/myproject/docs/README.md
2. ~/work/myproject/docs/hoge.md
3. ~/work/myproject/docs/fuga.md
...

💡 推奨アクション:
全ファイルを LF に変換するには:
/convert-crlf ~/work/myproject/docs/
```

### 変換実行モード

```
🔄 CRLF → LF 変換中...

✅ hoge.md
✅ fuga.md
✅ piyo.md
✅ foo.md
✅ bar.md
✅ baz.md
✅ qux.md
✅ hogehoge.md
✅ foobar.md
✅ sample1.md
✅ sample2.md
✅ README.md

📊 変換完了: 12ファイル
```

## 処理フロー

```
1. 入力パラメータ検証
   ↓
2. find で CRLF ファイルを検出
   ↓
3. 検出結果を整理
   ↓
4. (dry-run の場合)
   └─ 検出レポートを出力して終了
   ↓
5. (変換実行の場合)
   ├─ 各ファイルを sed で CRLF → LF に変換
   ├─ file コマンドで変換確認
   └─ 変換サマリを出力
```

## 注意事項

### Git での改行コード設定

`.gitattributes` で改行コードを統一することを推奨:

```
# .gitattributes
* text=auto eol=lf
*.md text eol=lf
```

### バイナリファイルの除外

バイナリファイル（画像、PDF等）は自動的に除外される（`file` コマンドの結果に `CRLF` が含まれない）。

### エディタの設定

エディタで改行コードを LF に設定することを推奨:

- **VS Code**: `files.eol: "\n"`
- **Vim**: `set fileformat=unix`
- **Sublime Text**: `"default_line_ending": "unix"`

### Windows での注意

Windows では `sed -i` の動作が異なる場合があるため、Git Bash または WSL の使用を推奨。

## 使用例

### 基本的な使用（変換実行）

```bash
/convert-crlf ~/work/myproject/docs/
```

### dry-run（検出のみ）

```bash
/convert-crlf ~/work/myproject/docs/ --dry-run
```

### 特定のファイルパターンのみ対象

```bash
/convert-crlf ~/work/myproject/ --file-pattern="*.rb"
```

### 単一ファイルの変換

```bash
/convert-crlf ~/work/myproject/docs/README.md
```

### 除外ディレクトリ指定

```bash
/convert-crlf ~/work/myproject/ --exclude="node_modules,vendor,.git"
```

## 成果物

### dry-run モード

- **検出レポート**: CRLF を含むファイルのリスト

### 変換実行モード

- **変換済みファイル**: CRLF → LF に変換されたファイル
- **変換サマリ**: 変換完了ファイル数のレポート

## よくある質問

### Q1. 変換後に Git で差分が出る？

A. `.gitattributes` で改行コードを統一していない場合、全行が変更として表示される。事前に `.gitattributes` を設定することを推奨。

### Q2. バイナリファイルも変換される？

A. `file` コマンドで CRLF を検出したファイルのみ変換されるため、バイナリファイルは自動的に除外される。

### Q3. 元に戻せる？

A. このスキルはバックアップを作成しないため、Git で管理されていない場合は元に戻せない。重要なファイルは事前にバックアップを作成すること。

### Q4. 一度に何ファイルまで変換できる？

A. システムの制限に依存するが、通常は数千ファイルまで変換可能。大量のファイルがある場合は、ディレクトリごとに分けて実行することを推奨。

### Q5. 変換に失敗した場合は？

A. 各ファイルの変換後に `file` コマンドで確認し、CRLF が残っている場合は警告を表示する。
