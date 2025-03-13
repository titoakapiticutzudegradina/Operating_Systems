#!/bin/sh
# Write a shell script which takes as parameters two files names (a file that
# contains usernames and a file that contains any text). The script will send a mail
# to each user in the first file (the mail message will be the text in the
# second file).
#
# Checking if the number of arguments is correct
if [ $# -ne 2 ]; then
    echo "Incorrect number of parameters"
    echo "Usage: $0 <usernames_file> <text_file>"
    exit 1
fi

#Checking if the parameters are files
if [ ! -f "$1" ]; then
    echo "The first parameter is not a file"
    exit 1
fi

if [ ! -f "$2" ]; then
    echo "The second parameter is not a file"
    exit 1
fi

while read -r user; do
    mail -s "Message" "$user" < "$2"
done < "$1"
