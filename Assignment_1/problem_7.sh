#!/bin/sh
# Write a shell script which takes as parameters a directory name. The script will
# determine the total number of lines in all ASCII text files in this directory and its
# subdirectories. It is assumed that any directory will only contain ASCII text files.
#
# Checking if the number of arguments is correct
if [ $# -ne 1 ]; then
    echo "Incorrect number of parameters"
    echo "Usage: $0 <directory>"
    exit 1
fi

#Check if the parameter is a directory
if [ ! -d "$1" ]; then
    echo "The parameter is not a directory"
    exit 2
fi

files=$(find "$1" -type f -exec file {} \; | grep -i 'ascii text' | cut -d: -f1)

for file in $files; do
    lines=$(wc -l < "$file")
    total=$((total+lines))
done

echo "Number of lines in all ASCII text files: $total"
