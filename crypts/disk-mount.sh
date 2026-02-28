#!/usr/bin/env bash

mountable=$(lsblk -lp | grep "part $" | awk '{print $1, "(" $4 ")"}')

[[ "$mountable" = "" ]] && exit 1

chosen=$(echo "$mountable" | dmenu -i -l 8 -p "elegí drive para montar" | awk '{print $1}')

[[ "$chosen" = "" ]] && exit 1

# sudo mount "$chosen" && exit 0 # descomentar para montar automaticamente drives de fstab

dirs=$(find /home/mounts -type d -maxdepth 3 2>/dev/null)
mountpoint=$(echo "$dirs" | dmenu -i -l 8 -p "elegí punto de montaje")

[[ "$mountpoint" = "" ]] && exit 1

if [[ ! -d "$mountpoint" ]]; then
    mknewdir=$(echo -e "no\nyes" | dmenu -i -l 2 -p "¿$mountpoint no existe, querés crearlo?")
    [[ "$mknewdir" = "yes" ]] && sudo mkdir -p "$mountpoint"
fi

sudo mount "$chosen" "$mountpoint" && pgrep -x dunst && notify-send "$chosen montado en $mountpoint"

exit 0
