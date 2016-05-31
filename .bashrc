# .bashrc

[ -z "$PS1" ] && return

if [ -z ${DESKTOP_SESSION+x} ]; then
    # we have a non-desktop session
    :
else
    # we have a desktop session
    # PROMPT_COMMAND is run before every shell execution
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD##*/}\007"; if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi;'
fi

#User defined functions
function backup { /bin/tar "czf" "$@" "$@.tgz" ;}
welcome() {
    if command -v figlet 1>/dev/null; then
        figlet Welcome Back $USER
    else
        echo "Welcome Back $USER"
    fi
}
# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases 
    source ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# source things if they exist
if [ -d "$HOME/.pythonrc" ]; then
    export PYTHONSTARTUP=~/.pythonrc
fi

if [ -f "$HOME/.dircolors" ]
then
    eval $(dircolors -b $HOME/.dircolors)
elif [ -f "/etc/dircolors" ]
then
    eval $(dircolors -b /etc/dircolors)
fi

if [ -d "$HOME/.aws" ]; then
    export AWS_CONFIG_FILE='~/.aws/config'
fi

if [ -d "$HOME/google-cloud-sdk" ]; then
    # The next line updates PATH for the Google Cloud SDK.
    source '/home/zephyr/google-cloud-sdk/path.bash.inc'
    # The next line enables bash completion for gcloud.
    source '/home/zephyr/google-cloud-sdk/completion.bash.inc'
    alias goapp=~/google-cloud-sdk/platform/google_appengine/goapp
fi
if [ -d "/usr/lib64/openmpi" ]; then
    export PATH=$PATH:/usr/lib64/openmpi/bin
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib64/openmpi/lib
fi

# Exports
username='\e[1;34m\u\e[0m';
hostname='\e[0;32m\h\e[0m';
directory='\e[1;36m\W\e[0m';
commandnumber='\e[1;31m$?\e[0m';
time='\@'
export PS1="-[$username@$hostname]-[$directory $commandnumber] - $time\n-> "

export PATH="$PATH:/usr/local/bin"
export XDG_CONFIG_COME='~/.config'
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export VISUAL=vim
export EDITOR="$VISUAL"
export JAVA_HOME=/usr/lib/jvm/default-java

##History
export HISTSIZE=10000
export HISTCONTROL=erasedups
shopt -s histappend

#computer-specific bashrc
if [ -f "$HOME/.localbashrc" ]; then
    source $HOME/.localbashrc
fi


###Startup
welcome
ls
