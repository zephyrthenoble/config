# .bash_aliases

if type -P dnf 1>/dev/null 2>&1; then 
INSTALLER="dnf"
elif type -P apt-get 1>/dev/null 2>&1; then
INSTALLER="apt-get"
elif type -P yum 1>/dev/null 2>&1; then 
INSTALLER="yum"
fi

alias install="$INSTALLER install"
alias uninstall="$INSTALLER remove"
alias update="$INSTALLER update"
alias upgrade="$INSTALLER upgrade"

alias sinstall="sudo $INSTALLER install"
alias suninstall="sudo $INSTALLER remove"
alias supdate="sudo $INSTALLER update"
alias supgrade="sudo $INSTALLER upgrade"

alias ghistory="history | grep"
alias gps="ps aux | grep"

# User specific aliases and functions
alias path='echo -e ${PATH//:/\\n}'
alias ls='ls --sort=extension --color=auto'
alias ll='ls -l -a'
alias cd..='cd ..'
alias dl='cd ~/Downloads'
alias python='python2'
alias rm='rm -i'

# Require sudo
alias systemctl="sudo systemctl"
