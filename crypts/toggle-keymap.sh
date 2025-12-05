#!/usr/bin/env bash

current=$(setxkbmap -query | awk '/layout/ {print $2}')

if [ "$current" = "latam" ]; then
    setxkbmap us
else
    setxkbmap latam
fi
