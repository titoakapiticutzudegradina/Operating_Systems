#!/bin/sh
# Write a shell script that reads words from keyboard (the reading stops when
# the user has entered the word "stop"). The script will display the list of words
# entered from the keyboard.
#
while true; do
    #Read a word from keyboard
    printf "Enter a word: "
    read -r word

    #Exit is the word is "stop"
    if [ "$word" = "stop" ]; then
        break
    fi

    words+=("$word")
done

#Display the list of words entered from the keyboard
echo "The list of words entered from the keyboard is: ${words[@]}"
