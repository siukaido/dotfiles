# inits/

init-loader で読み込まれる Emacs 設定ファイル群。
プレフィックスの番号順 → アルファベット順に読み込まれる。

## カテゴリ

| プレフィックス | カテゴリ | 説明 |
|---|---|---|
| `00-` | エディタ基本設定 | テーマ、キーバインド、空白表示など |
| `10-` | 開発支援ツール | Copilot、flycheck、検索など言語横断のツール |
| `20-` | 主要言語/ファイルタイプ | Go, TypeScript, Ruby, PHP など日常的に使う言語 |
| `30-` | その他の言語/ファイルタイプ | たまに使う言語や設定ファイル系 |

## 手動対応

### JavaScript/TypeScript (20-tsx.el)

```sh
npm install -g typescript typescript-language-server eslint
# prettier は brew install prettier で管理
```

Emacs 上で tree-sitter grammar をインストール:

```
M-x treesit-install-language-grammar RET javascript
M-x treesit-install-language-grammar RET typescript
M-x treesit-install-language-grammar RET tsx
```

### Go (20-go.el)

```sh
go install golang.org/x/tools/cmd/goimports@latest
go install golang.org/x/tools/gopls@latest
```

### GitHub Copilot (10-copilot.el)

```
M-x copilot-login
```

### Markdown プレビュー (20-markdown.el)

```sh
brew install pandoc
```

## 補完・LSP 構成

- **補完 UI**: corfu (capf ベース)
- **LSP**: eglot (組み込み)
- **構文チェック**: flycheck + flycheck-inline
