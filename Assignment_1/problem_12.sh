#!/bin/bash
# Write a shell script which takes as parameter a directory name.
# The script will display the filename,
# and the first 3 lines of each ASCII text file found in that directory.

directory=$1

#Check if the parameter is a directory
if [ ! -d "$directory" ]; then
    echo "Error: $directory is not a directory."
    exit 1
fi

files=$(find "$directory" -type f -exec file {} \; | grep -i 'ascii text' | cut -d: -f1)

for file in $files; do
    echo "File: $file"
    head -n 3 "$file"
    echo "-------------------------"
done
