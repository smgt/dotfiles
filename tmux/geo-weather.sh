#!/bin/sh

data=$(cat /tmp/geo-weather)
humidity=$(echo "$data"|grep humidity|cut -d " " -f2-)
temperature=$(echo "$data"|grep temperature|cut -d " " -f2-)
pressure=$(echo "$data"|grep pressure|cut -d " " -f2-)
echo "☼ ${temperature}° $humidity $pressure ⡇"
