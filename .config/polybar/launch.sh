#!/bin/bash
#
# restarts polybar on each connected monitor

POLYBAR_DIR="/usr/bin"

# Terminate already running bar instances
${POLYBAR_DIR}/polybar-msg cmd quit

if type "xrandr"; then
  for monitor in $(xrandr --query | grep " connected" | cut -d " " -f1); do
    MONITOR="${monitor}" ${POLYBAR_DIR}/polybar \
           --reload polybar 1>"/tmp/polybar-${USER}-${monitor}.log" 2>&1 & disown
  done
else
  ${POLYBAR_DIR}/polybar --reload polybar 1>"/tmp/polybar-${USER}.log" 2>&1 & disown
fi
