
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
