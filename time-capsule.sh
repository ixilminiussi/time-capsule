#!/bin/bash
version="1.0"

#validates parameter
if [ -z "$1" ]
then 
    echo "tmc: no files specified. try \"tmc --help\""
    exit
fi

RECURSIVE_MODE=false
ARCHIVE_PATH=`cat ~/.time-capsule`

#calls appropriate functions
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            ./commands/help.sh
            exit
            ;;

        -i|--init)
            ./commands/init.sh $2
            shift
            shift
            ;;
        -r|--recursive)
            RECURSIVE_MODE=true
            shift
            shift
            ;;
        -*|--*)
            echo "Unknown option $1"
            exit 1
            ;;
        *)
            if [ ! -s $ARCHIVE_PATH ]
            then
                echo "tmc: no archive directory specified. try \"tmc --help\""
                exit 1
            fi

            if [ $RECURSIVE_MODE = true ]
            then
                ./commands/recursive.sh $ARCHIVE_PATH $1 
            else
                ./commands/archive.sh $ARCHIVE_PATH $1 
            fi
            shift
            ;;
    esac
done

