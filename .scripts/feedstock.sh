#!/bin/bash

set -euf -o pipefail

command=$1
feedstock=$2
branch=${3:-master}

git subtree $command --prefix $feedstock git@github.com:AnacondaRecipes/$feedstock $branch