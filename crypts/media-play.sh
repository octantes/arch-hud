#!/usr/bin/env bash

status=$(playerctl --all-players status 2>/dev/null)

if echo "$status" | grep -q "Playing"; then
    playerctl --all-players pause
else
    playerctl --all-players play
fi
