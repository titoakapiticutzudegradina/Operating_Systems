#!/bin/bash

# Write a shell script which takes as parameters several file names.
# The script will delete the last 3 characters on each line in the given files.

# Loop over each file passed as argument
for file in $@; do
  # Check if the file exists
  if [ -f "$file" ]; then
      sed -i "s/...$//" $file
      #... -any 3 characters
      # $ - end of the line
  else
    echo "File $file not found."
  fi
done
