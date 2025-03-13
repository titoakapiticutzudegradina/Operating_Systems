#!/bin/sh
# Write a shell script that takes a natural number as parameters.
# The script will check wheter the given number is prime or not.
#
#Checking if the correct number of parameters was given
if [ $# -ne 1 ]; then
    echo "Incorrect number of parameters"
    echo "Usage: $0 <number>"
    exit 1
fi

#Checking if the parameter is a natural number
if ! [[ $1 =~ ^[0-9]+$ ]]; then
    echo "The parameter is not a natural number"
    exit 2
fi

isprime(){
    n=$1
    if [ $n -lt 2 ]; then
        echo "The number is not prime"
        exit 0
    fi
    for ((i=2; i<=n/2; i++)); do
        if [ $((n%i)) -eq 0 ]; then
            echo "The number is not prime"
            exit 0
        fi
    done
    echo "The number is prime"
}

isprime $1
