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
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi
