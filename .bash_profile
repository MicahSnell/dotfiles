# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

# setup ssh socket for ssh-agent.service
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

# startx if on tty1
if [ -z "${DISPLAY}" ] && [ "$(tty)" == "/dev/tty1" ]; then
  exec startx -- -keeptty &> ~/.local/share/xorg/Xorg.0.log
fi
