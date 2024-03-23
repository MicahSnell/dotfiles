# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:/usr/local/go/bin" ]]; then
  PATH="$HOME/.local/bin:$HOME/bin:/usr/local/go/bin:$PATH"
fi
export PATH

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
unset rc

# environment variables
export EDITOR="/usr/bin/emacs"
export PS1="\[\e[1;33m\][\[\e[1;36m\]\w\[\e[1;33m\]]\[\e[1;32m\]$\[\e[0m\] "
export HISTCONTROL=ignoreboth

# source user service environment variables
set -o allexport
. ~/.config/environment.d/user_service_envvars.conf
set +o allexport

# keybindings
bind '"\eh": backward-kill-word'
