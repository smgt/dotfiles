#!/usr/bin/env bash
options="Suspend
Reboot
Power Off"
selection=$(echo -e "${options}" | rofi -dmenu -m -3)
case "${selection}" in
  "Suspend")
    notify-send "polybar" "Suspend"
    systemctl suspend
    exit;;
  "Reboot")
    notify-send "polybar" "Reboot"
    systemctl reboot
    exit;;
  "Power Off")
    notify-send "polybar" "Power Off"
    systemctl power-off
    exit;;
esac
