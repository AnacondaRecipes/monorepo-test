#!/bin/bash

aggregate_dir=$1

(
    cd $aggregate_dir
    git submodule foreach
) | sed -E "s/.*Entering '(.*)'.*/\1/" | while read feedstock; do

    found=$(find . -type d -name $feedstock)
    num_found=$(echo $found | wc -l)
    if [[ -z "$found" ]]; then
        num_found=0
    fi
    if [[ $num_found -gt 1 ]]; then
        echo "Found multiple"
        exit 1
    fi

    branch=$(grep -A3 "submodule \"$feedstock\"" $aggregate_dir/.gitmodules | grep branch | awk '{ print $3 }')

    if [[ $num_found -eq 0 ]]; then
        ./.scripts/feedstock.sh add $feedstock $branch
    else
        ./.scripts/feedstock.sh pull $feedstock $branch
    fi

    exit
done