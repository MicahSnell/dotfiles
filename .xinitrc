#!/bin/sh

# load .Xresources
xrdb -load ~/.Xresources

# disable the stupid bell
xset b off

# disable display power management settings so xscreensaver can manage
xset -dpms

# launch xscreensaver
xscreensaver &

# set background image
~/.config/feh/fehbg

# use picom for transparent windows
picom -b

# launch window manager with dbus
exec dbus-launch --exit-with-session /usr/bin/i3
