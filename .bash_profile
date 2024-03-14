# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# startx if on tty1
if [ -z "${DISPLAY}" ] && [ "$(tty)" == "/dev/tty1" ]; then
  exec startx -- -keeptty &> ~/.local/share/xorg/Xorg.0.log
fi
