#!/bin/sh

# load color theme
update_theme.sh

# disable the stupid bell
xset b off

# disable display power management settings so xscreensaver can manage
xset -dpms

# launch xscreensaver
xscreensaver &

# set background image
~/.config/feh/fehbg

# use picom for transparent windows
picom --daemon --backend glx

# launch window manager
exec /usr/bin/i3
