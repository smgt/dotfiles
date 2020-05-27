#!/usr/bin/env bash
options="one
two
three"
theme=${1:-$HOME/.dotfiles/xorg/rofi/smgt.rasi}
selection=$(echo -e "${options}" | rofi -dmenu -config $theme)
case "${selection}" in
  "one")
    #notify-send "run_rofi.sh" "one";;
    exit;;
  "two")
    notify-send "run_rofi.sh" "two";;
  "three")
    notify-send "run_rofi.sh" "three";;
esac
