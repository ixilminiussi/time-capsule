#!/bin/bash
version="1.0"

init() {
    if [ -z $1 ]
    then
        echo "Usage: capsule --init <directory>"
        exit
    fi

    if [ -d $1 ]
    then
        realpath $1 > ~/.config/time-capsule.conf
        echo "`realpath $1` set as new archive directory!"
    else
        echo "capsule: cannot use '$1': No such directory"
        exit 1
    fi
}

#validates parameter
if [ -z $1 ]
then 
    echo "capsule: no files specified. try \"capsule --help\""
    exit
fi

if [ ! -f ~/.config/time-capsule.conf ]
then
    touch ~/.config/time-capsule.conf
fi

DIRECTORY_MODE=false
CREATION_MODE=false
ARCHIVE_PATH=`cat ~/.config/time-capsule.conf`

#calls appropriate functions
while [[ $# -gt 0 ]]; do
    case $1 in
        #--HELP----------------------#
        -h|--help)
            echo "
Usage: capsule [options] [file(s)]

Options 
    --help | -h
        See helpful commands
    --init | -i <dir>
        Set permanent directory to archive to
    --dir | -d <dir>
        Archive whole directory
        
    <file>
        will mv the specified file/folder into the archive folder according to its final date of editing, and remove write permissions for non-root users.
            "
            exit 0
            ;;

        #--INIT----------------------#
        -i|--init)
            init $2
            shift
            shift
            ;;

        #--DIRECTORY-----------------#
        -d|--dir)
            DIRECTORY_MODE=true
            shift
            ;;

        #--DIRECTORY-----------------#
        -c|--creation)
            CREATION_MODE=true
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
                echo "capsule: no archive directory specified. try \"capsule --help\""
                exit 1
            fi

            if [ ! -d $ARCHIVE_PATH ]
            then
                echo "capsule: $ARCHIVE_PATH is no longer a directory or has moved. Specify new archive directory with \"capsule [-i|--init] <directory>\""
                exit 1
            fi

            if [ $DIRECTORY_MODE = false ]
            then
                archive $ARCHIVE_PATH $CREATION_MODE $1
            else
                archive-dir $ARCHIVE_PATH $CREATION_MODE $1
            fi
            shift
            ;;
    esac
done
