#!/bin/bash
version="1.0"

if [ ! -e $2 ]
then
    echo "tmc: cannot archive '$2': No such file or directory"
    exit 1
fi

if [ -d $2 ] 
then
    echo "tmc: cannot archive '$2': Use [-d|--dir] to archive directories"
    exit 2
else
    # Get the last modification time of the file
    LAST_MODIFIED=`stat -c %y $2`

    # Extract year and month from the last modification time
    YEAR=`date -d "$LAST_MODIFIED" +%Y`
    MONTH=`date -d "$LAST_MODIFIED" +%m`

    mkdir -p "$1"/"$YEAR"/"$MONTH"
    mv -vn $2 "$1"/"$YEAR"/"$MONTH"
fi
shift
