#!/bin/bash
echo "
Usage: tmc [options] [file(s)]

Options 
    --help | -h
        See helpful commands
    --init | -i <dir>
        Set permanent directory to archive to
    --recursive | -r <dir>
        Find and archive files within directory separately

    <file | dir>
        will mv the specified file/folder into the archive folder according to its final date of editing, and remove write permissions for non-root users.
"
