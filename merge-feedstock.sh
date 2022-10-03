#!/bin/bash

set -euf -o pipefail

feedstock=$1
branch=${2:-master}

git checkout feedstocks/$feedstock/$branch

for file in $(git ls-files); do
    mkdir -p $(dirname $feedstock/$file)
    git mv $file $feedstock/$file
done

git commit -m "import $feedstock"

REV=$(git rev-parse HEAD)

git checkout main

git merge $REV --allow-unrelated-histories

