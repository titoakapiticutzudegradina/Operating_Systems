#!/bin/bash
# Write a shell script which takes as parameter a username (ex: bdae0198).
# The script will determine the section
# (extract the letters on positions 3 and 4)
# and the sum of all digits in the username.

username=$1

section=$(echo $username | cut -c 3-4)
sum=0
for ((i=0; i<${#username}; i++)); do
    if [[ ${username:$i:1} =~ [0-9] ]]; then
        sum=$((sum + ${username:$i:1}))
    fi
done

echo "Section: $section"
echo "Sum of digits: $sum"
