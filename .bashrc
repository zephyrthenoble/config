# .bashrc

[ -z "$PS1" ] && return

PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

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


username='\e[1;34m\u\e[0m';
hostname='\e[0;32m\h\e[0m';
directory='\e[1;36m\W\e[0m';
commandnumber='\e[1;31m$?\e[0m';

export PS1="-[$username@$hostname]-[$directory $commandnumber]\n-> "


# User specific aliases and functions
alias path='echo -e ${PATH//:/\\n}'
alias ls='ls --sort=extension --color=auto'
alias ll='ls -l -a'
alias cd..='cd ..'
alias dl='cd ~/Downloads'
alias python='python2.7'
alias rm='rm -i'
alias rustc="/usr/bin/rustc"

alias pip="sudo pip"
alias yum="sudo yum"
alias yumi="sudo yum install"
alias yumu="sudo yum update"
alias apt-get="sudo apt-get"
alias apti="sudo apgt-get install"


export PATH="$PATH:/usr/local/bin"
export AWS_CONFIG_FILE='awscli.conf'
export XDG_CONFIG_COME='~/.config'


function backup { /bin/tar "czf" "$@" "$@.tgz" ;}
if [ -f "$HOME/.dircolors" ]
then
eval $(dircolors -b $HOME/.dircolors)

elif [ -f "/etc/dircolors" ]
then
  eval $(dircolors -b /etc/dircolors)
fi



###Startup
welcome
ls


