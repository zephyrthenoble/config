#! /bin/bash
# link all files to the home directory, asking about overwrites
cd `dirname $0`
FORCE=false
INTERACTIVE=false
while getopts ":fuh" opt; do
  case $opt in
    u)
      echo "interactive"
      INTERACTIVE=true
      ;;
    h)
      echo "Run without arguments to update symlinks\n\n-i interactively replace symlinks"
      exit
      ;;
    \?)
      echo "Invalid args, try -h"
      exit
      ;;
  esac
done

containsElement () {
  local e
  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
  return 1
}

#using SCRIPT_DIR allows us to get the absolute path to the files in this repo
SCRIPT_DIR=`pwd`
SCRIPT_NAME=`basename $0`
FILES=`git ls-tree --name-only HEAD`
IGNORE=("README.md" "install.sh" "update.sh" ".gitmodules" ".gitconfig")
if [ -d "$HOME/.config" ] && !  [ -L "$HOME/.config" ]; then
    mv $HOME/.config backup.conf
    cp -rT backup.conf .config
    echo "Moved and copied .config"
fi
if [ -d "$HOME/.vim" ] && !  [ -L "$HOME/.vim" ]; then
    mv $HOME/.vim backup.vim
    cp -rT backup.vim .vim
    echo "Moved and copied .vim"
fi
echo $FILES
# go to home and start making symlinks
cd $HOME
for FILE in $FILES; do
    DIRECTORY=`dirname $FILE`
    # we don't need some files

    echo $FILE
    if ! containsElement "$FILE" "${IGNORE[@]}" ; then
        if [ "$INTERACTIVE" = true ] && [ -L "$FILE" ]; then
            ln -v --symbolic --interactive $SCRIPT_DIR/$FILE $HOME/$FILE
        else
            ln -v -s -f -n $SCRIPT_DIR/$FILE $HOME/$FILE
        fi
    fi
done
mkdir $HOME/.logs
