#!/bin/sh

# Finds duplicate files.
#
# Step 1: Generate a sorted checksum file. Examples:
#     cksum *.jpg | sort -n > filelist
#     find . -type f -exec cksum {} \; | sort -n > filelist
#
# Step 2: Execute this file. Example:
#     findDuplicateFiles.sh < filelist 

old=""
oldFile=""
while read sum lines filename
do
    if [[ "$sum" != "$old" ]]; then
        old="$sum"
	oldFile="$filename"
	continue
    fi
    cmp -s "$oldFile" "$filename"
    if [ $? = 0 ]; then
        echo "$filename is same as $oldFile"
    else
        echo "$filename has same checksum as $oldFile but is different"
    fi
done
