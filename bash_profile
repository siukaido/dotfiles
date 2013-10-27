# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/login.defs
#umask 022

# set ssh-agent
agentPID=`ps gxww|grep "ssh-agent]*$"|awk '{print $1}'`
agentSOCK=`/bin/ls -t /tmp/ssh*/agent*|head -1`
if [ "$agentPID" = "" -o "$agentSOCK" = "" ]; then
    unset SSH_AUTH_SOCK SSH_AGENT_PID
    eval `ssh-agent`
    ssh-add < /dev/null
else
    export SSH_AGENT_PID=$agentPID
    export SSH_AUTH_SOCK=$agentSOCK
    SSHADD=`ssh-add -l`
    if [ "$SSHADD" = "" ]; then
        ssh-add < /dev/null
    fi
fi

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi
