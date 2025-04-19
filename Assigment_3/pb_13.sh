#!/bin/bash

# Write a shell script that takes as parameters a short month name followed by a day number and a time interval (ex: Mar 8 11.00-12.00).
# The script will display the usernames and the total number of users that were connected to the server on that date and within that time frame
# using awk


if [ $# -ne 3 ]; then
    echo "Usage: $0 <Month> <Day> <HH.MM-HH.MM>"
    exit 1
fi

month=$1
day=$2
interval=$3

start_time=$(echo "$interval" | cut -d'-' -f1)
end_time=$(echo "$interval" | cut -d'-' -f2)

start_hour=$((10#$(echo "$start_time" | cut -d'.' -f1)))
start_min=$((10#$(echo "$start_time" | cut -d'.' -f2)))
end_hour=$((10#$(echo "$end_time" | cut -d'.' -f1)))
end_min=$((10#$(echo "$end_time" | cut -d'.' -f2)))

start_total=$((start_hour * 60 + start_min))
end_total=$((end_hour * 60 + end_min))


last | awk -v month="$month" -v day="$day" -v start="$start_total" -v end="$end_total" '
{
    if($5==month && $6 == day){
        for (i = 1; i < NF - 2; i++) {
            if ($i ~ /^[0-9]{2}:[0-9]{2}$/ && $(i+1) == "-" && $(i+2) ~ /^[0-9]{2}:[0-9]{2}$/) {
                split($i, login, ":")
                split($(i+2), logout, ":")

                login_min = login[1] * 60 + login[2]
                logout_min = logout[1] * 60 + logout[2]

                if (logout_min >= start && login_min <= end) {
                    print "User in interval : ", $0
                        count++
                }
            }
        }
    }
}
END {
    if (count == 0)
        print "Nothing found in the interval ... "
    else
        print "Total : ", count
}'
