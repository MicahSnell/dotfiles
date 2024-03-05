#!/bin/bash

status="$(playerctl --player=spotify status 2>/dev/null)"
title="$(playerctl --player=spotify metadata title | sed 's/ -.*//; s/ (.*//')"

if [ "$status" = "Playing" ]; then
  echo -e "♫ $title"
elif [ "$status" = "Paused" ]; then
  echo -e "\u25A0 $title"
else
  echo "idle"
fi
