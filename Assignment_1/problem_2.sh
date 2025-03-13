#!/bin/sh
# Write a shell script which takes as parameters two names of text files.
# The script will compare the two text files line by line and display the first
# 3 text line that differ.
#
#Check if exactly 2 parameters are given
if [ $# -ne 2 ]; then
    echo "Usage: $0 <file1> <file2>"
    exit 1
fi

#Check if the parameters are files
if [ ! -f $1 ] || [ ! -f $2 ]; then
    echo "The parameters are not files"
    echo "Usage: $0 <file1> <file2>"
    exit 1
fi

#Initialize a counter for the number of different lines
counter=0

#Iterate through the lines of the files
while IFS= read -r line1 && IFS= read -r line2 <&3; do
    if [ "$line1" != "$line2" ]; then
        counter=$((counter + 1))
        echo "Line $counter:"
        echo "File 1: $line1"
        echo "File 2: $line2"
        echo "---------------------------------"
    fi
done < $1 3< $2

#Message if the files are identical
if [ $counter -eq 0 ]; then
    echo "The files are identical"
fi
