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

###
# git aware cd
gcd() {
    if [[ $(which git 2> /dev/null) ]]
    then
        STATUS=$(git status 2>/dev/null)
        if [[ -z $STATUS ]]
        then
            return
        fi
        TARGET="./$(git rev-parse --show-cdup)$1"
        #echo $TARGET
        cd $TARGET
    fi
}
_gcd()
{
    if [[ $(which git 2> /dev/null) ]]
    then
        STATUS=$(git status 2>/dev/null)
        if [[ -z $STATUS ]]
        then
            return
        fi
        TARGET="./$(git rev-parse --show-cdup)"
        if [[ -d $TARGET ]]
        then
            TARGET="$TARGET/"
        fi
        COMPREPLY=()
        cur="${COMP_WORDS[COMP_CWORD]}"
        prev="${COMP_WORDS[COMP_CWORD-1]}$2"
        dirnames=$(cd $TARGET; compgen -o dirnames $2)
        opts=$(for i in $dirnames; do  if [[ $i != ".git" ]]; then echo $i/; fi; done)
        if [[ ${cur} == * ]] ; then
            COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
            return 0
        fi
    fi
}
complete -o nospace -F _gcd gcd
