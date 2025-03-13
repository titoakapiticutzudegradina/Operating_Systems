#!/bin/sh
# Write a shell scirpt that reads numbers from the keyboard (the reading stops when
# the user has entered the number 0). The script will display the sum of the numbers
# entered from the keyboard.
#
sum=0
while true; do
    printf "Enter a number: "
    read -r num

    #Checking if the number is valid
    if ! [[ $num =~ ^[0-9]+$ ]]; then
        echo "The parameter is not a number"
        continue
    fi

    #Check if the number is 0
    if [ $num -eq 0 ]; then
        break
    fi

    #Doing the sum
    sum=$((sum+num))
done

echo "The sum of the numbers is: $sum"
