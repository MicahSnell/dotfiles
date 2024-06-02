#!/bin/bash
#
# outputs a tmux formatted string containing the user, host, and git branch names of
# the active tmux pane
#
# args: 1=pane tty, 2=pane pid, 3=pane current path

cd "$3" || exit 1
gitInfo="$(gitmux -cfg ${HOME}/.config/tmux/gitmux.conf) "

remoteHost=$(ps -t "$1" -o ppid,args 2>/dev/null |
               grep "$2 ssh" |
               sed -e 's/\s\+\-\+[0-9A-Za-z]\+//g' \
                   -e 's/[0-9A-Za-z]\+@//' \
                   -e 's/[0-9A-Za-z]\+=[0-9A-Za-z]\+//g' |
               awk '{printf $3}')
if [ -n "${remoteHost}" ]; then
  hostName="$(ssh -G "${remoteHost}" | awk '/^hostname /{sub (/\..*/, ""); print $NF}')"
  userName="$(ssh -G "${remoteHost}" | awk '/^user /{print $NF}')"
  gitInfo="#[bg=default]"
else
  hostName="$(hostname)"
  userName="$(whoami)"
fi

echo "${gitInfo}#[fg=colour2]#[fg=colour0,bg=colour2,bold] ${userName} \
#[bg=colour2,fg=colour0]#[fg=colour2,bg=colour0] ${hostName} "
