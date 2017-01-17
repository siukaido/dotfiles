# ~/.bashrc: executed by bash(1) for non-login shells.
[ -z "$PS1" ] && return
shopt -s checkwinsize
export EDITOR=/usr/bin/emacs
export PATH=/usr/local/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/sbin:/bin
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export PATH=$PATH:/Applications/Xcode.app/Contents/Developer/usr/bin
export PATH=$PATH:~/.aws/AWS-ElasticBeanstalk-CLI-2.6.4/eb/macosx/python2.7/
export LIBRARY_PATH=/usr/local/include/:${LIBRARY_PATH}
export HISTTIMEFORMAT="%y/%m/%d %H:%M:%S: "
export GOPATH="${HOME}/.go"
export CONNECTION_REFRESH="true"

# Bash 4.0 の拡張機能
shopt -s globstar
#shopt -s autocd
shopt -s dirspell

# 複数端末間で履歴を共有
function share_history {
    history -a
    history -c
    history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend
export HISTSIZE=300000

# 日本語設定
export LANG=ja_JP.UTF-8
export LC_AL=ja_JP.UTF-8

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval `dircolors ~/.dir_colors`
    alias ls='ls --color=auto'
fi

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" -a -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# vagrant completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
    GIT_PS1_SHOWDIRTYSTATE=true
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-256color)
    PS1='${debian_chroot:+($debian_chroot)}\033k\033\\\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;33m\]\w\[\033[00m\]\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '
    ;;
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\033k\033\\\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;33m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# ファーストログインはscreenを自動起動
# if [ `ps aux | grep "$USER" | grep screen | grep -v Xvfb | wc -l` -le 1 ];
# then
#    if [ -e /var/run/screen/S-"$USER"/* ];
#    then
#        screen -r
#    else
#        screen
#    fi
# fi

# alias設定
# some more ls aliases
alias ll="ls -l"
alias la="ls -a"
alias l="ls"
alias s="ls"
alias u="uptime"

alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

function chpwd() {
	cd $1;
	pwd;
}
alias cd="chpwd"
alias e="emacs"
alias bye="exit"
alias quit="exit"
alias rmds='sudo find /. -name ".DS_Store" -exec rm {} \;'

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
eval "$(thefuck --alias)"
