#!/bin/bash

killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
if [ -z "$MONITOR" ];then
  export MONITOR=$(xrandr |grep primary | awk '{print $1}')
fi
polybar default -q -r &
