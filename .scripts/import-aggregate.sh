#!/bin/bash

set -euf -o pipefail

import() {
    feedstock=$1 
    aggregate_dir=$2
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
}

process_aggregate=true
while [[ $# -ne 0 ]]; do
    case $1 in
        --aggregate)    aggregate_dir=$2; shift 2 ;;
        *)              import $1 $aggregate_dir; process_aggregate=false; shift 1 ;;
    esac
done

if [[ $process_aggregate == true ]]; then
    (
        cd $aggregate_dir
        git submodule foreach
    ) | sed -E "s/.*Entering '(.*)'.*/\1/" | while read feedstock; do

        import $feedstock $aggregate_dir

    done
fi