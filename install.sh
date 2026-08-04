#!/bin/bash

# relink target-file source-file
relink() {
    if [[ -h "$1" ]]; then
        echo "Relinking $1"
        # Symbolic link? Then recreate.
        rm "$1"
        ln -sn "$2" "$1"
    elif [[ ! -e "$1" ]]; then
        echo "Linking $1 to $2"
        ln -sn "$2" "$1"
    else
        echo "$1 exists as a real file, skipping."
    fi
}

DIR=$( cd "$( dirname "$0" )" && pwd )

relink ~/.bash_profile $DIR/bash_profile
relink ~/.bashrc       $DIR/bashrc
relink ~/.bash_aliases $DIR/bash_aliases
relink ~/.zprofile     $DIR/zprofile
relink ~/.zshrc        $DIR/zshrc
relink ~/.dir_colors   $DIR/dir_colors
relink ~/.gitconfig    $DIR/gitconfig
relink ~/.inputrc      $DIR/inputrc
relink ~/.screenrc     $DIR/screenrc
relink ~/.tmux.conf    $DIR/tmux.conf
relink ~/.emacs.d      $DIR/emacs.d
mkdir -p ~/.codex
relink ~/.codex/AGENTS.md $DIR/CLAUDE.md # codexもclaudeと同等の設定を使うため
mkdir -p ~/.claude
relink ~/.claude/CLAUDE.md $DIR/CLAUDE.md
relink ~/.claude/settings.json $DIR/claude/settings.json
relink ~/.claude/statusline-command.sh $DIR/claude/statusline-command.sh
relink ~/.claude/subagent-statusline.sh $DIR/claude/subagent-statusline.sh
mkdir -p ~/.claude/skills
relink ~/.claude/skills/crlf-to-lf-converter $DIR/claude/skills/crlf-to-lf-converter
relink ~/.claude/skills/dependabot-pr-reviewer $DIR/claude/skills/dependabot-pr-reviewer
mkdir -p ~/.bundle
relink ~/.bundle/config $DIR/bundle/config
mkdir -p ~/.config
relink ~/.config/ghostty $DIR/ghostty

if [ "$(uname)" == "Darwin" ]; then
    # macOS 専用のシンボリックリンク（iCloud経由）
    relink ~/.bash_local "/Users/$(whoami)/Library/Mobile Documents/com~apple~CloudDocs/work/0.dotfiles/bash_local"
    relink ~/.aws "/Users/$(whoami)/Library/Mobile Documents/com~apple~CloudDocs/work/0.dotfiles/aws"
    relink ~/.ssh "/Users/$(whoami)/Library/Mobile Documents/com~apple~CloudDocs/work/0.dotfiles/ssh"

    # Homebrew
    echo ""
    if hash brew 2>/dev/null; then
        echo "UPDATE Homebrew"
        brew update
    else
        echo "INSTALL Homebrew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    echo "Exec brew bundle"
    brew bundle

    # anyenv（Brewfile でインストール済み）
    echo "Using anyenv"
    if [ ! -d ~/.anyenv ]; then
        anyenv init
        mkdir -p "$(anyenv root)/plugins"
        git clone https://github.com/znz/anyenv-update.git "$(anyenv root)/plugins/anyenv-update"

        anyenv install goenv
        anyenv install rbenv
        anyenv install nodenv
        anyenv install phpenv
        echo "anyenv の環境をインストールしました。シェルを再起動してください。"
    fi
fi
