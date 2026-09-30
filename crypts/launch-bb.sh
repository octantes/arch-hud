#!/usr/bin/env bash

# blackbook launcher: ensure the node server is running, then open it in surf
# usage: launch-bb.sh [embed-window-id]

BB="http://localhost:3000"

bash /home/cadenas/blackbook/launch.sh

win="$1"
if [ -n "$win" ] && xprop -id "$win" 2>/dev/null | grep -q '"tabbed"'; then
  exec surf -e "$win" "$BB"
else
  exec tabbed -c -r 2 surf -e X "$BB"
fi