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
LOCAL_BIN_PATH="${HOME}/bin"
XCODE_BIN_PATH="/Applications/Xcode.app/Contents/Developer/usr/bin"
GO_BIN_PATH="${GOPATH}/bin"
PATH="${LOCAL_BIN_PATH}:${PATH}:${XCODE_BIN_PATH}:${GO_BIN_PATH}"
if [ -x /opt/homebrew/bin/brew ]; then
    # Brew関連のpathを設定
    eval $(/opt/homebrew/bin/brew shellenv)

    # gnubin
    if [ -d $(brew --prefix)/opt/coreutils/libexec/gnubin ]; then
        GNUBIN_PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin"
        PATH="${GNUBIN_PATH}:${PATH}"
    fi

    # flutter
    if [ -d $(brew --prefix)/Caskroom/flutter/3.10.6/flutter/bin ]; then
        FLUTTER_BIN_PATH="$(brew --prefix)/Caskroom/flutter/3.10.6/flutter/bin"
        PATH="${FLUTTER_BIN_PATH}:${PATH}"
    fi
else
    echo "does not exist homebrew!!"
fi
export PATH

# LIBRARY_PATH設定
export LIBRARY_PATH=/usr/local/include/:${LIBRARY_PATH}

# item2 の設定読み込み
if [ -f "${HOME}/.iterm2_shell_integration.bash" ]; then
    source "${HOME}/.iterm2_shell_integration.bash"
fi

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
