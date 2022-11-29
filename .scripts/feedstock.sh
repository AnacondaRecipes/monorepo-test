#!/bin/bash

set -euf -o pipefail

command=$1
feedstock=$2
path=${3:-$feedstock}
branch=${4:-master}

git subtree $command --prefix $path git@github.com:AnacondaRecipes/$feedstock $branch
