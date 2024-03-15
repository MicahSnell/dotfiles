#!/bin/bash

cd "$(dirname $0)"

# copy archive contents to location of .git directory
gitDir="$(cat ../../.git | cut -d ' ' -f2)"
copyTo="$(dirname $gitDir)/"
copyFrom="$(realpath ../../)/"
echo "Copying the contents of $copyFrom to $copyTo"
rsync --recursive --links --exclude ".git" --exclude README "$copyFrom" "$copyTo"

# initialize submodules, don't show untracked files for the dotfiles repo
echo "Initializing $gitDir"
cd "$copyTo"
git --git-dir="$gitDir" --work-tree="$copyTo" submodule update --init --recursive "$copyTo"
git --git-dir="$gitDir" --work-tree="$copyTo" config status.showUntrackedFiles no

echo "Removing $copyFrom"
rm -rf "$copyFrom"

echo "Complete"
