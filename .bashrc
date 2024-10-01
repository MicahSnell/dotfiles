# .bashrc

# source bash completion
if [[ -r /usr/share/bash-completion/bash_completion ]]; then
  . /usr/share/bash-completion/bash_completion
fi

# source aliases and functions
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "${rc}" ]; then
      . "${rc}"
    fi
  done
fi
unset rc

# export environment variables
if [ -z "${TMUX}" ]; then
  export PS1="$(printf '%s' \
             "\[\e[1;37m\][\[\e[1;34m\]\u\[\e[0m\]@\[\e[1;33m\]\h \[\e[1;36m\]\W" \
             "\[\e[1;31m\]\$(get_branch)\[\e[1;37m\]]\[\e[1;32m\]$\[\e[0m\] ")"
else
  export PS1="\[\e[1;37m\][\[\e[1;36m\]\w\[\e[1;37m\]]\[\e[1;32m\]$\[\e[0m\] "
fi

if ! [[ "${PATH}" =~ "${HOME}/.local/bin:${HOME}/bin" ]]; then
  PATH="${HOME}/.local/bin:${HOME}/bin:${PATH}"
fi
export PATH

export HOSTNAME
export EDITOR="/usr/bin/emacs"
export HISTCONTROL=ignoreboth

# source user service environment variables
set -o allexport
. ~/.config/environment.d/user_service_envvars.conf
set +o allexport

# keybindings
if [ -t 1 ]; then
  bind '"\eh": backward-kill-word'
fi
