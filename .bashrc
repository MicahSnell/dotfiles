# .bashrc

get_branch ()
{
  git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:/usr/local/go/bin" ]]
then
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

# source aliases
source ~/.config/aliases

# environment variables
export EDITOR="/usr/bin/emacs"
export PS1="[\[\e[1;36m\]\u\[\e[0m\]@\[\e[1;33m\]\h\[\e[0m\] \W\[\e[31m\]\$(get_branch)\[\e[0m\]]\[\e[1;32m\]$\[\e[0m\] "
export HISTCONTROL=ignoreboth
