#!/bin/bash

# find the same feedstock in multiple subdirectories

failed=false
find . -type d -name "*-feedstock" | grep -v "./.git/*" | while read feedstock_path; do
    feedstock=$(basename $feedstock_path)
    num_found=$(find . -type d -name $feedstock | wc -l)
    if [[ $num_found -ne 1 ]]; then
        failed=true
        echo "Found duplicates of feedstock $feedstock:"
        find . -type d -name $feedstock
    fi
done

if [[ $failed == true ]]; then
    exit 1
fi