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
      echo "-f force removal of everything\n-u updates symlinks, only making new ones"
      exit
      ;;
    \?)
      echo "Invalid args, try -h"
      exit
      ;;
  esac
done

git submodule init
git submodule update
bash update.sh

SCRIPT_DIR=`pwd`
SCRIPT_NAME=`basename $0`
FILES=`git ls-tree -r --name-only HEAD`
delete=README.md
echo $FILES
cd $HOME
for FILE in $FILES; do
    DIRECTORY=`dirname $FILE`
    # we don't need some files
    if [ $FILE != "README.md" ] && [ $FILE != "install.sh" ] && [ $FILE != "update.sh" ]; then
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
    fi
done
