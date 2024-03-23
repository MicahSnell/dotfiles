# dotfiles
Local configuration files and scripts, managed only with git. Inspired by
[jaagr](https://github.com/jaagr/dots), see this repo for more details on usage.

## Cloning
When cloning, specify where the actual .git directory should be written and a directory to
temporarily copy the repo into.
```bash
$ git clone --separate-git-dir=$HOME/.dotfiles git@github.com:/MicahSnell/dotfiles /tmp/dotfiles
```
A script is provided to simplify copying files from the temporary directory. It clones the files
into the appropriate directories, initializes any submodules, and removes the temporary directory
when finished.
```bash
$ /tmp/dotfiles/.config/dotfiles/install
```
