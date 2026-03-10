# 日本語設定
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

# エディタ設定
export EDITOR=emacs

# コマンド履歴設定
export HISTTIMEFORMAT="%y/%m/%d %H:%M:%S: "
export HISTSIZE=300000
export CONNECTION_REFRESH="true"

# go / goenvの設定
export GOPATH="${HOME}/go"
export GOENV_DISABLE_GOPATH=1

# PATH設定
## /usr/local/sbin を追加したいため上書き
PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"
if [ "$(uname)" == "Darwin" ]; then
    PATH="${PATH}:/Library/Apple/usr/bin"
fi
LOCAL_BIN_PATH="${HOME}/bin"
XCODE_BIN_PATH="/Applications/Xcode.app/Contents/Developer/usr/bin"
GO_BIN_PATH="${GOPATH}/bin"
PATH="${LOCAL_BIN_PATH}:${PATH}:${XCODE_BIN_PATH}:${GO_BIN_PATH}"

BREW_PATH="/opt/homebrew/bin/brew"
if [ "$(uname)" == "Linux" ]; then
    BREW_PATH="/home/linuxbrew/.linuxbrew/bin/brew"
fi

if [ -x "$BREW_PATH" ]; then
    # Brew関連のpathを設定
    eval "$("$BREW_PATH" shellenv)"

    BREW_PREFIX="$(brew --prefix)"

    # gnubin
    if [ -d "${BREW_PREFIX}/opt/coreutils/libexec/gnubin" ]; then
        GNUBIN_PATH="${BREW_PREFIX}/opt/coreutils/libexec/gnubin"
        PATH="${GNUBIN_PATH}:${PATH}"
    fi

    # flutter（バージョンに依存しない動的パス解決）
    FLUTTER_DIR=$(ls -d "${BREW_PREFIX}/Caskroom/flutter"/*/flutter/bin 2>/dev/null | head -1)
    if [ -n "$FLUTTER_DIR" ]; then
        PATH="${FLUTTER_DIR}:${PATH}"
    fi

    # aqua
    if [ -x "${BREW_PREFIX}/bin/aqua" ]; then
        PATH="${HOME}/.local/share/aquaproj-aqua/bin/:${PATH}"
    fi

    # LIBRARY_PATH設定
    CPATH="${BREW_PREFIX}/include:${CPATH}"
    LIBRARY_PATH="${BREW_PREFIX}/lib/:${LIBRARY_PATH}"
    export LIBRARY_PATH
else
    echo "does not exist homebrew!!"
fi
export PATH

# iterm2 の設定読み込み
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
