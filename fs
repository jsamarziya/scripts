#!/bin/sh
# 
# Prints info about file count, total file size, and directory count
#

if [ "$1" = "" ]; then
    echo usage $0 directory
    exit 0
fi

find "$1" -type f -ls | awk '{files +=1; total +=$7};END {printf "%d files (%d bytes)\n", files, total }' 
find "$1" -type d | awk '{directories +=1};END {printf "%d directories\n", directories  }'
