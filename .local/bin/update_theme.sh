#!/bin/bash
#
# applies settings from xrdb to applications that do not use it internally
#
# args: none

# update X server resource data base
xrdb -load "${HOME}/.Xresources"

# get foreground and background
export FOREGROUND="$(xrdb -get foreground)"
export BACKGROUND="$(xrdb -get background)"

# add fixed amount to background to create alternate background
highlight="1447453"
sum="$(($((16${BACKGROUND})) + highlight))"
export BACKGROUND_ALT="$(printf '#%x' ${sum})"

# add it to Xresource data base
xrdb -merge <(echo "*.background-alt: ${BACKGROUND_ALT}")

# colors 0 through 15
export COLOR_0="$(xrdb -get color0)"
export COLOR_1="$(xrdb -get color1)"
export COLOR_2="$(xrdb -get color2)"
export COLOR_3="$(xrdb -get color3)"
export COLOR_4="$(xrdb -get color4)"
export COLOR_5="$(xrdb -get color5)"
export COLOR_6="$(xrdb -get color6)"
export COLOR_7="$(xrdb -get color7)"
export COLOR_8="$(xrdb -get color8)"
export COLOR_9="$(xrdb -get color9)"
export COLOR_10="$(xrdb -get color10)"
export COLOR_11="$(xrdb -get color11)"
export COLOR_12="$(xrdb -get color12)"
export COLOR_13="$(xrdb -get color13)"
export COLOR_14="$(xrdb -get color14)"
export COLOR_15="$(xrdb -get color15)"

# generate config files from template files
tmplFiles=(
  "${HOME}/.config/alacritty/alacritty.toml.template"
  "${HOME}/.config/rofi/style.rasi.template"
)

for template in "${tmplFiles[@]}"; do
  config="${template%.template}"
  envsubst < "${template}" > "${config}"
done
