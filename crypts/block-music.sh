#!/usr/bin/env bash

# refresh always when track changes
pidof -x playerctl-loop >/dev/null 2>&1 || playerctl-loop >/dev/null 2>&1 &

# displays artist or album acording to format
META="{{ title }} - {{ artist }}"

# iterates players and finds the one playing
for PLAYER in chromium spotify mpd; do
    [ "$(playerctl --player=$PLAYER status 2>/dev/null)" != "Playing" ] && continue
    echo "r $(playerctl metadata --player $PLAYER --format "$META")" \
        | tr '[:upper:]' '[:lower:]'
    exit 0
done

# prints final text
echo "p" | tr '[:upper:]' '[:lower:]'
