#!/bin/bash
#
# outputs icon and song name of current song on spotify, depending on status
#
# args: none

status="$(playerctl --player=spotify status 2>/dev/null)"
title="$(playerctl --player=spotify metadata title | sed 's/ -.*//; s/ (.*//')"

if [ "${status}" = "Playing" ]; then
  echo -e "♫ $title"
elif [ "${status}" = "Paused" ]; then
  echo -e "■ $title"
else
  echo "idle"
fi
