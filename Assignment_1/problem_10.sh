#!/bin/sh

# Write a shell script which takes as parameter an existing group number (ex:
# 821). The script will display the user name, the full name and the home
# directory of each student in that group.
#
# Checking if the correct number of parameters was given
if [ $# -ne 1 ]; then
    echo "Incorrect number of parameters"
    echo "Usage: $0 <group_number>"
    exit 1
fi

#Checking if the parameter is a number
if ! [[ $1 =~ ^[0-9]+$ ]]; then
    echo "The parameter is not a number"
    exit 2
fi

group=$1

group_info=$(getent group $group)

echo "Group details:" $group_info
