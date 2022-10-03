#!/bin/bash

feedstock=$1

git remote add $feedstock git@github.com:AnacondaRecipes/$feedstock || exit 1
git config --local remote.$feedstock.fetch "+refs/heads/*:refs/feedstocks/$feedstock/*"
git remote update $feedstock
