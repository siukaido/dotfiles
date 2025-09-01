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
relink ~/.dir_colors   $DIR/dir_colors
relink ~/.gitconfig    $DIR/gitconfig
relink ~/.inputrc      $DIR/inputrc
relink ~/.screenrc     $DIR/screenrc
relink ~/.emacs.d      $DIR/emacs.d
mkdir ~/.claude
relink ~/.claude/CLAUDE.md $DIR/CLAUDE.md
relink ~/.bash_local "/Users/`whoami`/Library/Mobile Documents/com~apple~CloudDocs/work/0.dotfiles/bash_local"
relink ~/.aws "/Users/`whoami`/Library/Mobile Documents/com~apple~CloudDocs/work/0.dotfiles/aws"
relink ~/.ssh "/Users/`whoami`/Library/Mobile Documents/com~apple~CloudDocs/work/0.dotfiles/ssh"

mkdir ~/.bundle
relink ~/.bundle/config $DIR/bundle/config

if [ `uname` == "Darwin" ]; then
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
    brew tap Homebrew/bundle
    brew bundle

    # anyenv
    echo "Using anyenv"
    if [ ! -d ~/.anyenv ]; then
        git clone https://github.com/riywo/anyenv ~/.anyenv
        exec $SHELL -l
        # anyenv update
        mkdir -p $(anyenv root)/plugins
        git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/any

        anyenv install goenv
        anyenv install rbenv
        anyenv install ndenv
        anyenv install phpenv
    fi
fi

# App Store
echo ""
echo "application install from AppStore"
## runcat
mas install 1429033973
## LINE
mas install 539883307
## 1Password for safari
mas install 1569813296
## Xcode
mas install 497799835
