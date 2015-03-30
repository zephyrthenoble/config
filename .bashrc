# .bashrc

[ -z "$PS1" ] && return

if [ -z ${DESKTOP_SESSION+x} ]; then
    # we have a non-desktop session
    :
else
    # we have a desktop session
    # PROMPT_COMMAND is run before every shell execution
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
fi

#User defined functions
function backup { /bin/tar "czf" "$@" "$@.tgz" ;}
welcome() {
    if command -v figlet 1>/dev/null; then
        figlet Welcome Back $USERNAME
    else
        echo "Welcome Back $USERNAME"
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
export PS1="-[$username@$hostname]-[$directory $commandnumber]\n-> "
export PATH="$PATH:/usr/local/bin"
export AWS_CONFIG_FILE='~/.aws/config'
export XDG_CONFIG_COME='~/.config'
export PYTHONSTARTUP=~/.pythonrc
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export JAVA_HOME=/usr/java/jdk.8.0_25
export LFS=/mnt/lfs
export VISUAL=vim
export EDITOR="$VISUAL"


##History
export HISTSIZE=10000
export HISTCONTROL=erasedups
shopt -s histappend

###Startup
welcome
ls
