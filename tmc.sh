#!/bin/bash
version="1.0"

#validates parameter
if [ -z $1 ]
then 
    echo "tmc: no files specified. try \"tmc --help\""
    exit
fi

if [ ! -f ~/.time-capsule ]
then
    touch ~/.time-capsule
fi

DIRECTORY_MODE=false
ARCHIVE_PATH=`cat ~/.time-capsule`

#calls appropriate functions
while [[ $# -gt 0 ]]; do
    case $1 in
        #--HELP----------------------#
        -h|--help)
            echo "
Usage: tmc [options] [file(s)]

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
            exit
            ;;

        #--INIT----------------------#
        -i|--init)
            if [ -z $2 ]
            then
                echo "Usage: tmc --init <directory>"
                exit
            fi

            if [ -d $2 ]
            then
                realpath $2 > ~/.time-capsule
                echo "`realpath $2` set as new archive directory!"
            else
                echo "tmc: cannot use '$2': No such directory"
                exit 1
            fi
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
            exit 1
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


            if [ ! -e $1 ]
            then
                echo "tmc: cannot archive '$1': No such file or directory"
                exit 1
            fi

            if [ -d $1 ] && [ $DIRECTORY_MODE = false ]
            then
                echo "tmc: cannot archive '$1': Use [-d|--dir] to archive directories"
                exit 1
            else
                # Get the last modification time of the file
                LAST_MODIFIED=`stat -c %y $1`

                # Extract year and month from the last modification time
                YEAR=`date -d "$LAST_MODIFIED" +%Y`
                MONTH=`date -d "$LAST_MODIFIED" +%m`

                mkdir -p "$ARCHIVE_PATH"/"$YEAR"/"$MONTH"
                mv -vn $1 "$ARCHIVE_PATH"/"$YEAR"/"$MONTH"
            fi
            shift
            ;;
    esac
done



