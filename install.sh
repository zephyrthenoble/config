#! /bin/bash
# link all files to the home directory, asking about overwrites
cd `dirname $0`
FORCE=false
INTERACTIVE=false
while getopts ":fuh" opt; do
  case $opt in
    f)
      echo "forcing removal!"
      FORCE=true
      ;;
    u)
      echo "interactive"
      INTERACTIVE=true
      ;;
    h)
      echo "Run without arguments to only add new symlinks\n\n-f force removal of everything\n-i interactively replace symlinks"
      exit
      ;;
    \?)
      echo "Invalid args, try -h"
      exit
      ;;
  esac
done

git submodule init
# git submodule update
# bash update.sh
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
echo $FILES
# go to home and start making symlinks
cd $HOME
for FILE in $FILES; do
    DIRECTORY=`dirname $FILE`
    # we don't need some files

    echo $FILE
    if ! containsElement "$FILE" "${IGNORE[@]}" ; then
        echo "working on it"
        if [ "$FORCE" = true ] ; then
            ln -v -s -f -n $SCRIPT_DIR/$FILE $HOME/$FILE
        else
            if [ "$INTERACTIVE" = true ] && [ -L "$FILE" ]; then
                ln -v --symbolic --interactive $SCRIPT_DIR/$FILE $HOME/$FILE
            else
#                 echo "$FILE symlink already exists"
                    echo "$FILE created"
            fi
        fi
    fi
done
