#!/usr/bin/env bash

current=$(setxkbmap -query | awk '/layout/ {print $2}')

if [ "$current" = "latam" ]; then
    setxkbmap us
    notify-send "keymap" "us keymap enabled" 2>/dev/null

else
    setxkbmap latam
    notify-send "keymap" "latam keymap enabled" 2>/dev/null   
fi
