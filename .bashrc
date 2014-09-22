# .bashrc

[ -z "$PS1" ] && return

PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

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
fi


username='\e[1;34m\u\e[0m';
hostname='\e[0;32m\h\e[0m';
directory='\e[1;36m\W\e[0m';
commandnumber='\e[1;31m$?\e[0m';

export PS1="-[$username@$hostname]-[$directory $commandnumber]\n-> "

source ~/.bash_aliases

export PATH="$PATH:/usr/local/bin"
export GOPATH="/home/zephyr/gopath"
export AWS_CONFIG_FILE='awscli.conf'
export XDG_CONFIG_COME='~/.config'


if [ -f "$HOME/.dircolors" ]
then
eval $(dircolors -b $HOME/.dircolors)

elif [ -f "/etc/dircolors" ]
then
  eval $(dircolors -b /etc/dircolors)
fi

##History
export HISTSIZE=10000
export HISTCONTROL=erasedups
shopt -s histappend

###Startup
welcome
ls


