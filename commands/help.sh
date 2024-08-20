#!/bin/bash

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
