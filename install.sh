#! /bin/sh
# link all files to the home directory, asking about overwrites
cd `dirname $0`
FORCE=false
UPDATE=false
while getopts ":fuh" opt; do
  case $opt in
    f)
      echo "forcing removal!"
      FORCE=true
      ;;
    u)
      echo "updating only"
      UPDATE=true
      ;;
    h)
      echo "-f force removal of everything"
      exit
      ;;
    \?)
      echo "Invalid args, try -h"
      exit
      ;;
  esac
done

git submodule init
bash update.sh

SCRIPT_DIR=`pwd`
SCRIPT_NAME=`basename $0`
FILES=`git ls-tree -r --name-only HEAD`
delete="README.md"
FILES=${FILES/$delete/""}
delete="install.sh"
FILES=${FILES/$delete/""}
delete="update.sh"
FILES=${FILES/$delete/""}
cd $HOME
for FILE in $FILES; do
    DIRECTORY=`dirname $FILE`
    if [ "." != "$DIRECTORY" ]; then
        [ -d "$DIRECTORY" ] || mkdir -p $DIRECTORY
    fi
    if [ "$FORCE" = true ] ; then
        ln -v -s -f -n $SCRIPT_DIR/$FILE $FILE
    else
        if [ "$UPDATE" = true ] && [ -L "$FILE" ]; then
            echo "$FILE symlink already exists"
        else
            ln -v --symbolic --interactive $SCRIPT_DIR/$FILE $FILE
        fi
    fi
done
