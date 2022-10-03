#!/bin/bash

# import a repo with history into a subdir

set -euf -o pipefail

feedstock=$1
branch=${2:-master}

# create branch named after feedstock
git checkout main
git checkout feedstocks/$feedstock/$branch

# move files into feedstock subdirectory
for file in $(git ls-files); do
    mkdir -p $(dirname $feedstock/$file)
    git mv $file $feedstock/$file
done

# create a new detached commit
git commit -m "import $feedstock"
REV=$(git rev-parse HEAD)

# merge it back into main
git checkout main
git merge $REV --allow-unrelated-histories
