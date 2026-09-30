#!/usr/bin/env bash

status=$(playerctl --all-players status 2>/dev/null)

playerctl --all-players previous
