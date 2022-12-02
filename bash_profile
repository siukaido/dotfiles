# 日本語設定
export LANG=ja_JP.UTF-8
export LC_AL=ja_JP.UTF-8

# エディタ設定
export EDITOR=emacs

# コマンド履歴設定
export HISTTIMEFORMAT="%y/%m/%d %H:%M:%S: "
export HISTSIZE=300000
export CONNECTION_REFRESH="true"

# go設定
export GOPATH="${HOME}/go"
export GOENV_DISABLE_GOROOT=1
export GOENV_DISABLE_GOPATH=1

# PATH設定
## /usr/local/sbin を追加したいため上書き
PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/Library/Apple/usr/bin"
GNUBIN_PATH="/usr/local/opt/coreutils/libexec/gnubin"
LOCAL_BIN_PATH="${HOME}/bin"
XCODE_BIN_PATH="/Applications/Xcode.app/Contents/Developer/usr/bin"
GO_BIN_PATH="${GOPATH}/bin"
export PATH="${GNUBIN_PATH}:${LOCAL_BIN_PATH}:${PATH}:/usr/loca/sbin:${XCODE_BIN_PATH}:${GO_BIN_PATH}"
if [ -e /opt/homebrew/bin/brew ]; then
    eval $(/opt/homebrew/bin/brew shellenv)
fi
if [ -d $HOME/.anyenv ]; then
    eval "$(anyenv init -)"
else
    echo "plz install anyenv. @see https://github.com/riywo/anyenv"
fi
if [ -d $HOME/Applications/flutter ]; then
   export PATH="${PATH}:${HOME}/Applications/flutter/bin"
fi
if [ -f "${HOME}/Applications/google-cloud-sdk/path.bash.inc" ]; then
   source "${HOME}/Applications/google-cloud-sdk/path.bash.inc"
fi
if [ -f "${HOME}/Applications/google-cloud-sdk/completion.bash.inc" ]; then
   source "${HOME}/Applications/google-cloud-sdk/completion.bash.inc"
fi

# LIBRARY_PATH設定
export LIBRARY_PATH=/usr/local/include/:${LIBRARY_PATH}

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
# include .bash_aliases if it exists
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
# include .bash_local if it exists
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi
