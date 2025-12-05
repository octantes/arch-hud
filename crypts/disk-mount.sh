#!/usr/bin/env bash
# this script prompts unmounted drives and selects a mountpoint

mountable=$(lsblk -lp | grep "part $" | awk '{print $1, "(" $4 ")"}')
[[ "$mountable" = "" ]] && exit 1

chosen=$(echo "$mountable" | dmenu -i -p "select drive" | awk '{print $1}')
[[ "$chosen" = "" ]] && exit 1
# sudo mount "$chosen" && exit 0 // uncomment to automount fstab drives

dirs=$(find /home/mounts -type d -maxdepth 3 2>/dev/null)

mountpoint=$(echo "$dirs" | dmenu -i -p "select mountpoint")
[[ "$mountpoint" = "" ]] && exit 1

if [[ ! -d "$mountpoint" ]]; then
    mknewdir=$(echo -e "no-yes" | dmenu -i -p "$mountpoint does not exist, create it?")
    [[ "$mknewdir" = yes ]] && sudo mkdir -p "$mountpoint"
fi

sudo mount "$chosen" "$mountpoint" && pgrep -x dunst && notify-send "$chosen mounted to $mountpoint"
