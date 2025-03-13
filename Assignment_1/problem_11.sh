#!/bin/bash
# Write a shell script which lists the content of the current directory.
# The script will list the files as follows: sorted by file names,
# sorted by last modified date and sorted by file size.
#
choice=$1

if [ "$choice" == "name" ]; then
    ls -l | sort -k9
elif [ "$choice" == "date" ]; then
    ls -lt
elif [ "$choice" == "size" ]; then
    ls -lS
else
    echo "Invalid choice"
fi
