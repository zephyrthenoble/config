# .bash_aliases

if type -P yum 1>/dev/null 2>&1; then 
alias install="sudo yum install"
alias uninstall="sudo yum remove"
elif type -P apt-get 1>/dev/null 2>&1; then
alias install="sudo apt-get install"
alias uninstall="sudo apt-get remove"
fi

# User specific aliases and functions
alias path='echo -e ${PATH//:/\\n}'
alias ls='ls --sort=extension --color=auto'
alias ll='ls -l -a'
alias cd..='cd ..'
alias dl='cd ~/Downloads'
alias python='python2.7'
alias rm='rm -i'

# Require sudo
alias yum="sudo yum"
alias yumi="sudo yum install"
alias yumu="sudo yum update"
alias apt-get="sudo apt-get"
alias apti="sudo apt-get install"
alias systemctl="sudo systemctl"
alias lpf="sudo lpf"
alias pip="sudo pip"

