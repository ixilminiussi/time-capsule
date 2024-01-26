#!/bin/bash
#validates parameters
if [ -z "$2" ]
then
    echo "Usage: tmc [parameter] <file | directory>"
    exit
fi

if [ ! -d "$1" ]
then
    echo "tmc: '$1' is no longer a directory or has moved. Specify new archive directory with \"tmc -i <directory>\""
    exit 1
fi

if [ ! -e "$2" ]
then
    echo "tmc: cannot archive '$2': No such file or directory"
    exit 1
fi

# Get the last modification time of the file
LAST_MODIFIED=`stat -c %y "$2"`

# Extract year and month from the last modification time
YEAR=`date -d "$LAST_MODIFIED" +%Y`
MONTH=`date -d "$LAST_MODIFIED" +%m`

mkdir -p "$1"/"$YEAR"/"$MONTH"
mv -vn $2 "$1"/"$YEAR"/"$MONTH"
