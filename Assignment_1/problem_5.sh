#!/bin/sh
# Write a shell script that reads usernames from keyboard. For each user,
# the script will display the number of times it was logged in to the server in the
# current month. If he/she has not logged in at all during the current month, the
# script will display the message: "User X has never logged in during the
# current month".
#
# Function to count logins for a user in the current month
counter(){
    username=$1
    month=$(date +%b)

    # Count the number of logins for the user in the current month
    count=$(last | grep "$username" | grep "$month" | wc -l)

    # Display the result
    if [ $count -eq 0 ]; then
        echo "User $username has never logged in during the current month"
    else
        echo "User $username has logged in $count times during the current month"
    fi
}

#Main
while true; do
    #Read a username from keyboard
    printf "Enter a username: "
    read -r user

    #Exit is the user is "exit"
    if [ "$user" = "exit" ]; then
        break
    fi

    counter "$user"
done
