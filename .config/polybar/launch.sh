#!/bin/bash

POLYBAR="${HOME}/projects/opensource/polybar/build/bin"

# Terminate already running bar instances
${POLYBAR}/polybar-msg cmd quit

if type "xrandr"; then
  for monitor in $(xrandr --query | grep " connected" | cut -d " " -f1); do
    MONITOR="${monitor}" ${POLYBAR}/polybar \
           --reload polybar 1>"/tmp/polybar-${monitor}.log" 2>&1 & disown
  done
else
  ${POLYBAR}/polybar --reload polybar 1>/tmp/polybar.log 2>&1 & disown
fi
