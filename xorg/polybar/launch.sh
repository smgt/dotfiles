#!/bin/sh

killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
export MONITOR=$(xrandr |grep primary | awk '{print $1}')
polybar example -q -r &
