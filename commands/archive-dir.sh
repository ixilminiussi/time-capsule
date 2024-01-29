#!/bin/bash
version="1.0"

if [ ! -e $2 ]
then
    echo "tmc: cannot archive '$2': No such file or directory"
    exit 1
fi

if [ -f $2 ]
then
    echo "tmc: cannot archive '$2' : Use without [-d|--dir] to archive files"
    exit 2
fi

# Get the last modification time of the file
LAST_MODIFIED=`stat -c %y $2`

# Extract year and month from the last modification time
YEAR=`date -d "$LAST_MODIFIED" +%Y`
MONTH=`date -d "$LAST_MODIFIED" +%m`

mkdir -p "$1"/"$YEAR"/"$MONTH"
mv -vn $2 "$1"/"$YEAR"/"$MONTH"
