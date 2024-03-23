#!/bin/bash
#
# applies settings from xrdb to applications that do not use it internally
#
# args: none

# update X server resource data base
xrdb -load "${HOME}/.Xresources"

# get foreground and background
foreground="$(xrdb -get foreground)"
background="$(xrdb -get background)"

# add fixed amount to background to create alternate background
highlight="1447453"
sum="$(($((16${background})) + highlight))"
background_alt="$(printf '#%x' ${sum})"

# add it to Xresource data base
xrdb -merge <(echo "background-alt: ${background_alt}")

# update foreground and background in kitty
sed -i "/^foreground\s\+/{s/.*/foreground ${foreground}/}" "${HOME}/.config/kitty/kitty.conf"
sed -i "/^background\s\+/{s/.*/background ${background}/}" "${HOME}/.config/kitty/kitty.conf"

# update foreground, background, and background-alt in rofi
sed -i "s/\s\+foreground:.*\;$/  foreground: ${foreground};/" "${HOME}/.config/rofi/style.rasi"
sed -i "s/\s\+background:.*\;$/  background: ${background};/" "${HOME}/.config/rofi/style.rasi"
sed -i "s/\s\+background-alt:.*\;$/  background-alt: ${background_alt};/" "${HOME}/.config/rofi/style.rasi"

# update first sixteen colors in kitty and rofi
for c in {0..15}; do
  newColor="$(xrdb -get color${c})"
  sed -i "/^color${c}\s\+/{s/.*/color${c} ${newColor}/}" "${HOME}/.config/kitty/kitty.conf"
  sed -i "s/\s\+color${c}:.*\;$/  color${c}: ${newColor};/" "${HOME}/.config/rofi/style.rasi"
done
