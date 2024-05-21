#!/usr/bin/env bash
options=$(autorandr --list)
selection=$(echo -e "${options}" | rofi -dmenu -m -3)
if [ "$selection" != "" ];then
  notify-send "polybar" "Monitor: ${selection}"
  autorandr "${selection}"
fi
