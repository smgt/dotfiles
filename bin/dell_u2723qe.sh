#!/usr/bin/env bash

if [ "$EUID" -ne 0 ] && groups | grep -qwv 'i2c' && getent group i2c &> /dev/null
then
  echo "Insuficient permissions, run as root ou join $USER to i2c group."
  exit 1
fi


case "$1" in
  "switch")
    # if hdmi is active, then go to usb
    if ddcutil getvcp 60 | grep -q 'sl=0x11'; then
      # usb-c
      next_target="0x1b"
    # if usb is active, then go to hdmi
    elif ddcutil getvcp 60 | grep -q 'sl=0x1b'; then
      # display port
      next_target="0x0f"
    # if hdmi is active, tehn go to usb
    else
      # hdmi
      next_target="0x11"
    fi

    if [ "$2" = "usb-c" ]; then
      next_target="0x1b"
    elif [ "$2" = "dp" ]; then
      next_target="0x0f"
    elif [ "$2" = "hdmi" ]; then
      next_target="0x11"
    fi

    ddcutil setvcp 60 "$next_target"
    ;;
  "single_mode")
    # exit from pip/pbp
    ddcutil setvcp E9 0x0
    ;;
  "switch_pip_size")
    # switch between small and big pip window size
    ddcutil setvcp E9 0x01
    ;;
  "switch_pip_position")
    # switch pip window position
    ddcutil setvcp E9 0x2
    ;;
  "pip_mode_small")
    # enter on pip small window size
    ddcutil setvcp E9 0x21
    ;;
  "pip_mode_big")
    # enter on pip big window size
    ddcutil setvcp E9 0x1
    ;;
  "pbp_mode")
    # enter on pbp mode
    ddcutil setvcp E9 0x24
    ;;
  "switch_video")
    # switch video sources on pip/pbp mode
    ddcutil setvcp E5 0xF001
    ;;
  "switch_usb")
    # switch usb hub target on pip/pbp mode
    ddcutil setvcp E7 0xFF00
    ;;
  *)
    echo "Invalid argument, use switch [usb-c, dp, hdmi], single_mode, switch_pip_size, switch_pip_position, pip_mode_small, pip_mode_big, pbp_mode, switch_video, switch_usb"
    exit 1
    ;;
esac