#!/bin/bash
#
# outputs a tmux formatted string containing the user, host, and git branch names of
# the active tmux pane
#
# args: 1=pane tty, 2=pane pid, 3=pane current path

cd "$3" || exit 1
gitInfo="$(gitmux -cfg ${HOME}/.config/tmux/gitmux.conf) "

remoteHost="$(ps -t $1 -o ppid -o args 2>/dev/null | grep "$2 ssh" | grep -v grep | \
              awk -F ' ' '{print $NF}')"
if [ -n "${remoteHost}" ]; then
  hostName="$(ssh -G "${remoteHost}" | grep '^hostname ' | sed 's/.* //; s/\..*//')"
  userName="$(ssh -G "${remoteHost}" | grep '^user ' | sed 's/.* //')"
  gitInfo="#[bg=default]"
else
  hostName="$(hostname)"
  userName="$(whoami)"
fi

echo "${gitInfo}#[fg=colour2]#[fg=colour0,bg=colour2,bold] ${userName} \
#[bg=colour2,fg=colour0]#[fg=colour2,bg=colour0] ${hostName} "
