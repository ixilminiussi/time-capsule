#!/bin/bash

if [ ! -e $3 ]
then
    echo "capsule: cannot archive '$3': No such file or directory"
    exit 1
fi

if [ -d $3 ] 
then
    echo "capsule: cannot archive '$3': Use [-d|--dir] to archive directories"
    exit 2
else

    if [ $2 == true ]
    then
        # Get the last modification time of the file
        LAST_MODIFIED=`stat -c %w $3`
    else
        # Get the last modification time of the file
        LAST_MODIFIED=`stat -c %y $3`
    fi

    # Extract year and month from the last modification time
    YEAR=`date -d "$LAST_MODIFIED" +%Y`
    MONTH=`date -d "$LAST_MODIFIED" +%m`

    mkdir -p "$1"/"$YEAR"/"$MONTH"
    mv -vn $3 "$1"/"$YEAR"/"$MONTH"
fi
shift
