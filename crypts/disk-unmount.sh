#!/usr/bin/env bash
# this script prompts mounted drives and unmounts

exclusionregex="\(/boot/efi\|/home/kaste\|/home/archivo\|/home\|/\)$"

drives=$(lsblk -lp | grep "t /" | grep -v "$exclusionregex" | awk '{print $1, "(" $4 ")", "on", $7}')
[[ "$drives" = "" ]] && exit

chosen=$(echo "$drives" | dmenu -i -p "select drive to unmount" | awk '{print $1}')
[[ "$chosen" = "" ]] && exit

sudo umount "$chosen" && pgrep -x dunst && notify-send "$chosen unmounted"
