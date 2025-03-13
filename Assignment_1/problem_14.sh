#!/bin/bash
# Write a shell script which
# displays all files in the current directory and its subdirectories
# that have write permission for the group of which the owner belongs.
#

# Find all files in the current directory and its subdirectories
find . -type f | while read -r file; do
    # Get the file's permissions in symbolic format
    permissions=$(ls -ld "$file" | cut -c 1-10)

    # Check if the group write permission is set
    case "$permissions" in
        ?????w*) echo "$file" ;;
    esac
done
