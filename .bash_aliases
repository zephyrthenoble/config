# .bash_aliases

# add a proxy command to insert proxy information as build args
proxy_docker()                                                                   
{                                                                                
    if [ $# -gt 0 ] && [ "$1" == "build" ] && [ "$2" == "proxy" ] ; then         
        shift # build                                                            
        shift # proxy                                                            
        PROXY_VARIABLES=`env | grep -i proxy | sed -e 's/^/--build-arg "/' | sed -e 's/$/"/'`
        cmd="docker build $@ $PROXY_VARIABLES"
        echo "building with proxy variables"
        echo $PROXY_VARIABLES                                                    
        eval $cmd                                                                
    else                                                                         
        command docker "$@"                                                      
    fi                                                                           
}                                                                                
                                                                                 
alias docker="proxy_docker"      

alias ghistory="history | grep"
alias gps="ps aux | grep"

# User specific aliases and functions
alias path='echo -e ${PATH//:/\\n}'
alias ls='ls --sort=extension --color=auto'
alias ll='ls -l -a'
alias cd..='cd ..'
alias dl='cd ~/Downloads'
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
