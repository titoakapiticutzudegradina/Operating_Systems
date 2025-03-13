#!/bin/sh
# Write a shell script which takes as parameters two integers. The script will dsisplay the sum,
# the difference and the product of the two given integers.
#
echo "Enter two numbers: "
read int1 int2

# checking if the parameters are integers
if ! [[ $int1 != ^[0-9]+$ ]] || ! [[ $int2 != ^[0-9]+$ ]]; then
    echo "The parameters are not integers"
    echo "Usage: $0 <integer1> <integer2>"
    exit 1
fi

sum=$(($int1 + $int2))
diff=$(($int1 - $int2))
prod=$(($int1 * $int2))

echo "The sum of $int1 and $int2 is $sum"
echo "The difference of $int1 and $int2 is $diff"
echo "The product of $int1 and $int2 is $prod"
