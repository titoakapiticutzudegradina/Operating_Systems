#!/bin/bash
# Write a Shell program that, given a directory (as a parameter), creates a list
# of all the names that appear in it and its subdirectories (files, directories),
# and for each file it prints the maximum number of repeating lines
# (in the same file).


if [${1} -eq 0 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi
if [ ! -d "$1" ]; then
    echo "Error: $1 is not a directory"
    exit 1
fi
dir=$1

# Create a temporary file to store the list of files
temp_file=$(mktemp)
# Find all files in the directory and its subdirectories
find "$dir" -type f > "$temp_file"
# Loop through each file
while IFS= read -r file; do
    # Get the maximum number of repeating lines in the file
    max_repeats=$(awk '{count[$0]++} END {for (line in count) if (count[line] > max) max = count[line]; print max}' "$file")
    # Print the file name and the maximum number of repeating lines
    echo "File: $file, Max repeating lines: $max_repeats"
done < "$temp_file"
# Remove the temporary file
rm "$temp_file"
