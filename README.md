# dotfiles

macOS / WSL (Linux) 用の dotfiles。

## セットアップ

```sh
git clone git@github.com:<your-repo>/dotfiles.git ~/work/private/dotfiles
cd ~/work/private/dotfiles
./install.sh
```

`install.sh` が以下を自動で行う:

1. 各設定ファイルへのシンボリックリンク作成
2. Homebrew のインストール・更新（macOS のみ）
3. `brew bundle` による各種ツールのインストール（macOS のみ）
4. anyenv 環境のセットアップ（macOS のみ）
5. App Store アプリのインストール（macOS のみ）

## ファイル構成

| ファイル / ディレクトリ | 説明 |
|---|---|
| `bash_profile` | Bash ログインシェル設定 |
| `bashrc` | Bash 対話シェル設定 |
| `bash_aliases` | Bash エイリアス |
| `zprofile` | Zsh ログインシェル設定 |
| `zshrc` | Zsh 対話シェル設定 |
| `gitconfig` | Git グローバル設定 |
| `inputrc` | Readline 設定 |
| `screenrc` | GNU Screen 設定 |
| `tmux.conf` | tmux 設定 |
| `dir_colors` | ディレクトリカラー設定 |
| `emacs.d/` | Emacs 設定（詳細は `emacs.d/inits/README.md` を参照） |
| `bundle/config` | Bundler 設定 |
| `Brewfile` | Homebrew パッケージ一覧 |
| `install.sh` | セットアップスクリプト |
| `CLAUDE.md` | Claude Code 用の指示ファイル |

## macOS 固有の設定

### iCloud 経由のシンボリックリンク

以下のファイルは iCloud Drive 上に配置し、シンボリックリンクで参照する:

- `~/.bash_local` — マシン固有の Bash 設定
- `~/.aws` — AWS 認証情報
- `~/.ssh` — SSH 鍵・設定

### Homebrew

`Brewfile` で管理。`brew bundle` で一括インストールされる。

### App Store（mas）

`install.sh` 内で `mas` コマンドにより以下をインストール:

- RunCat
- LINE
- 1Password for Safari
- Xcode

## anyenv

Node.js / Go / Ruby / PHP のバージョン管理に [anyenv](https://github.com/anyenv/anyenv) を使用。
Homebrew でインストール後、`install.sh` が以下の `*env` をセットアップする:

- `goenv`
- `rbenv`
- `nodenv`
- `phpenv`

> **注意**: Node.js は `nodenv` で管理するため、Brewfile の `node` はコメントアウトしてある。

## Windows / WSL

WSL 環境でも同じ dotfiles を利用可能。`install.sh` の macOS 固有部分（Homebrew、iCloud リンク、mas）は `uname` で分岐しているため、Linux 環境ではスキップされる。
