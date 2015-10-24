# .bash_aliases

if type -P dnf 1>/dev/null 2>&1; then 
alias install="dnf install"
alias uninstall="dnf remove"
fi
elif type -P apt-get 1>/dev/null 2>&1; then
alias install="apt-get install"
alias uninstall="apt-get remove"
elif type -P yum 1>/dev/null 2>&1; then 
alias install="yum install"
alias uninstall="yum remove"
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
alias systemctl="sudo systemctl"
