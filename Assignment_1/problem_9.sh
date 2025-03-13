#!/bin/sh
# Write a shell script which takes as parameters a username.
# The script will count and display the number of processes that belong to that
# user .
#
# Checking if the correct number of parameters was given
if [ $# -ne 1 ]; then
    echo "Incorrect number of parameters"
    echo "Usage: $0 <username>"
    exit 1
fi

#Check if the user exists
if ! id "$1" &> /dev/null; then
    echo "The user does not exist"
    exit 2
fi

nr=0
for _ in $(ps -eo user,pid | awk -v user="$1" '$1== user {print $2}'); do
    nr=$((nr+1))
done

echo "The number of processes that belong to the user $1 is $nr"
