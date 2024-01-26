#!/bin/bash
#validates parameters
if [ -z "$1" ]
then
    echo "Usage: tmc --init <directory>"
    exit
fi

if [ -d "$1" ]
then
    realpath $1 > ~/.time-capsule
    echo "`realpath $1` set as new archive directory!"
else
    echo "tmc: cannot use '$1': No such directory"
    exit 1
fi

