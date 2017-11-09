# set ssh-agent
# agentPID=`ps gxww|grep "ssh-agent]*$"|awk '{print $1}'`
# agentSOCK=`/bin/ls -t /tmp/ssh*/agent*|head -1`
# if [ "$agentPID" = "" -o "$agentSOCK" = "" ]; then
#     unset SSH_AUTH_SOCK SSH_AGENT_PID
#     eval `ssh-agent`
#     ssh-add < /dev/null
# else
#     export SSH_AGENT_PID=$agentPID
#     export SSH_AUTH_SOCK=$agentSOCK
#     SSHADD=`ssh-add -l`
#     if [ "$SSHADD" = "" ]; then
#         ssh-add < /dev/null
#     fi
# fi

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

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ]; then
    PATH=~/bin:"${PATH}"
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
eval $(thefuck --alias)

if [ -d $HOME/.anyenv ]; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
else
    echo "plz install anyenv. @see https://github.com/riywo/anyenv"
fi
