#!/bin/bash

# use .git file to determine where actual .git directory was written
cd "$(dirname $0)"
clonedToDir="$(realpath ../../)"
gitDir="$(cat $clonedToDir/.git | awk '{print $NF}')"

# use git restore to "copy" archive contents at location of .git directory
cd "$(dirname $gitDir)"
echo "Initializing $gitDir"
git --git-dir="$gitDir" --work-tree="$PWD" restore .

# initialize submodules, don't show untracked files for the dotfiles repo
git --git-dir="$gitDir" --work-tree="$PWD" submodule update --init --recursive
git --git-dir="$gitDir" --work-tree="$PWD" config status.showUntrackedFiles no

echo "Removing $clonedToDir"
rm -rf "$clonedToDir"

echo "Complete"
