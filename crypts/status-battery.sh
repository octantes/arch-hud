#!/usr/bin/env bash

percentage=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk '/percentage/ {gsub(/%/, "", $2); print $2}')

if [[ $percentage -eq 100 ]] ; then
	echo "99%"
else
	echo "${percentage}%"
fi
