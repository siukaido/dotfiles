# コマンド履歴設定
export HISTSIZE=300000
export SAVEHIST=300000

# 補完システム
autoload -Uz compinit && compinit

# 大文字小文字を区別しない補完
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# シェルオプション
setopt CORRECT           # コマンドのスペル修正
setopt NO_BARE_GLOB_QUAL # ()をグロブ修飾子として解釈しない (ファイル名に()を含むディレクトリの補完用)
setopt SHARE_HISTORY     # 複数端末間で履歴を共有
setopt EXTENDED_HISTORY  # タイムスタンプ付き履歴
setopt HIST_IGNORE_DUPS  # 重複する履歴を無視
setopt PROMPT_SUBST      # プロンプト内の変数展開

# キーバインド (inputrc 相当)
bindkey '^N' history-search-forward
bindkey '^P' history-search-backward

# ls のカラー設定
if [[ -x $(brew --prefix)/bin/gdircolors ]]; then
    if [[ -f ~/.dir_colors ]]; then
        eval $(gdircolors ~/.dir_colors)
    fi
    alias ls='gls --color=auto'
else
    if [[ -f ~/.dir_colors ]]; then
        eval $(dircolors ~/.dir_colors)
    fi
    alias ls='ls --color=auto'
fi

# brew で入れたものの設定読み込み
if (( $+commands[brew] )); then
    # direnv
    if [[ -x $(brew --prefix)/bin/direnv ]]; then
        eval "$(direnv hook zsh)"
    else
        echo "does not exist direnv. plz install from brew"
    fi
    # thefuck
    if [[ -x $(brew --prefix)/bin/fuck ]]; then
        eval "$(thefuck --alias)"
    else
        echo "does not exist thefuck. plz install from brew"
    fi
    # anyenv
    if [[ -x $(brew --prefix)/bin/anyenv ]]; then
        if [[ -d $HOME/.anyenv ]]; then
            eval "$(anyenv init - zsh)"

            # goenv
            eval "$(goenv init - zsh)"
            export PATH="${GOROOT}/bin:${PATH}"

            # rbenv
            eval "$(rbenv init - --no-rehash zsh)"
        fi
    else
        echo "does not exist anyenv. plz install from brew"
    fi
    # google-cloud-sdk
    if [[ -f "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc" ]]; then
        source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
    fi
    if [[ -f "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc" ]]; then
        source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
    fi
fi

# vcs_info (git ブランチ表示)
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '+'
zstyle ':vcs_info:git:*' unstagedstr '*'
zstyle ':vcs_info:git:*' formats '(%b%u%c)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'

# プロンプト設定
# user@host:~/path
# 10:30 AM(main*+) $
PROMPT='%B%F{green}%n@%m%f%b:%B%F{yellow}%~%f%b
%B%F{green}%@%f%b%F{red}${vcs_info_msg_0_}%f $ '

# cd 後に pwd を表示 (zsh の chpwd フックを使用)
chpwd() {
    pwd
}

# alias設定
alias ll="ls -l"
alias la="ls -a"
alias l="ls"
alias s="ls"
alias u="uptime"

alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

alias e="emacs"
alias bye="exit"
alias quit="exit"
alias rmds='sudo find /. -name ".DS_Store" -exec rm {} \;'
alias be="bundle exec"

# git系
alias gitst="git st"
alias gci="git ci"
alias myfork="git branch -a | grep myfork"

# svn系
alias st="svn status"
alias svnst="svn status"
alias svns="svn status"
alias svndi="svn diff"
alias svnd="svn diff"

# docker
alias dc="docker compose"

# multi-agent-shogun aliases
alias css='cd "/Users/hideharu.saito/multi-agent-shogun" && ./shutsujin_departure.sh'
alias csm='cd "/Users/hideharu.saito/multi-agent-shogun"'

# pnpm
export PNPM_HOME="/Users/hideharu.saito/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
