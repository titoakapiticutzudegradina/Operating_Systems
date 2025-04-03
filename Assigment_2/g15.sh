#!/bin/sh

# Write a shell script which takes as parameter several file names.
# The script will display all the lines in the given files that contain only lowercase letters.

# Loop over each file passed as argument
for file in $@; do
  # Check if the file exists
  if [ -f "$file" ]; then
    # Find lines containing only lowercase letters and display them
    grep "^[a-z]*$" $file
  else
    echo "File $file not found."
  fi
done
