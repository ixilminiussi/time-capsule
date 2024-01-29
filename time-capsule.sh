#!/bin/bash
version="1.0"

#validates parameter
if [ -z $1 ]
then 
    echo "tmc: no files specified. try \"tmc --help\""
    exit
fi

if [ ! -f ~/.config/time-capsule.conf ]
then
    touch ~/.config/time-capsule.conf
fi

DIRECTORY_MODE=false
ARCHIVE_PATH=`cat ~/.config/time-capsule.conf`

#calls appropriate functions
while [[ $# -gt 0 ]]; do
    case $1 in
        #--HELP----------------------#
        -h|--help)
            ./commands/help.sh
            exit 0
            ;;

        #--INIT----------------------#
        -i|--init)
            ./commands/init.sh $2
            shift
            shift
            ;;

        #--DIRECTORY-----------------#
        -d|--dir)
            DIRECTORY_MODE=true
            shift
            ;;

        #--UNKOWN--------------------#
        -*|--*)
            echo "Unknown option $1"
            exit 2
            ;;

        #--FILES---------------------#
        *)
            if [ ! -s $ARCHIVE_PATH ]
            then
                echo "tmc: no archive directory specified. try \"tmc --help\""
                exit 1
            fi

            if [ ! -d $ARCHIVE_PATH ]
            then
                echo "tmc: $ARCHIVE_PATH is no longer a directory or has moved. Specify new archive directory with \"tmc [-i|--init] <directory>\""
                exit 1
            fi

            if [ $DIRECTORY_MODE = false ]
            then
                ./commands/archive.sh $ARCHIVE_PATH $1
            else
                ./commands/archive-dir.sh $ARCHIVE_PATH $1
            fi
            shift
            ;;
    esac
done



