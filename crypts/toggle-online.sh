#!/usr/bin/env bash

if nmcli -t -f NETWORKING networking | grep -q "enabled"; then
    nmcli networking off
    notify-send "network" "offline mode enabled" 2>/dev/null
else
    nmcli networking on
    notify-send "network" "online mode enabled" 2>/dev/null
fi
