# .bashrc

# do nothing when in eshell or tramp
if [[ "${TERM}" == "dumb" ]]; then
  return
fi

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

reset="\[\e[0m\]"
red="\[\e[1;31m\]"
green="\[\e[1;32m\]"
yellow="\[\e[1;33m\]"
blue="\[\e[1;34m\]"
magenta="\[\e[1;35m\]"
cyan="\[\e[1;36m\]"
white="\[\e[1;37m\]"

# export environment variables
if [[ "${TERM}" == "screen-256color" ]]; then
  export PS1="${white}[${cyan}\w${red}\$(get_branch)${white}]${green}\$${reset} "
else
  export PS1="$(printf '%s' \
             "${white}[${blue}\u${reset}@${yellow}\h ${cyan}\W" \
             "${red}\$(get_branch)${white}]${green}\$${reset} ")"
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

# keybindings, 2 space tabs, set dir colors
if [ -t 1 ]; then
  bind '"\eh": backward-kill-word'
  if type tabs &>/dev/null; then
    tabs -2
  fi
  if type dircolors &>/dev/null; then
    . <(dircolors)
  fi
fi
