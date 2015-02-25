#! /bin/sh
# link all files to the home directory, asking about overwrites
cd `dirname $0`
SCRIPT_DIR=`pwd`
SCRIPT_NAME=`basename $0`
FILES=`git ls-tree -r --name-only HEAD`
delete="README.md"
FILES=${FILES/$delete/""}
delete="install.sh"
FILES=${FILES/$delete/""}
cd $HOME
for FILE in $FILES; do
    DIRECTORY=`dirname $FILE`
    if [ "." != "$DIRECTORY" ]; then
        [ -d "$DIRECTORY" ] || mkdir -p $DIRECTORY
    fi
    echo $SCRIPT_DIR/$DIRECTORY/$FILE
    ln --symbolic --interactive $SCRIPT_DIR/$FILE $FILE
done
