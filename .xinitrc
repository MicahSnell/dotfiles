#!/bin/sh

# load color theme
update_theme.sh

# set background image
~/.config/feh/fehbg

# use picom for transparent windows
picom --daemon --backend glx

# disable the stupid bell
xset b off

# put monitor in standby mode after 30 minutes
xset dpms 1800 0 0

# lock screen after 10 minutes
xset s 600

# launch window manager
exec /usr/bin/i3
