#!/usr/bin/env bash

exclusionregex="^(/boot/efi|/home/kaste|/home/archivo|/home/extra|/home/havitat|/home|/)$"

drives=$(lsblk -lp | grep "t /" | awk -v excl="$exclusionregex" '
    $7 ~ excl { next }           # salta si el mountpoint coincide exactamente con la regex
    { print $1 " (" $4 ") en " $7 }
')

[[ -z "$drives" ]] && exit 0

chosen=$(echo "$drives" | dmenu -i -l 8 -p "elegí drive para desmontar" | awk '{print $1}')

[[ -z "$chosen" ]] && exit 0

if sudo umount "$chosen" 2>/dev/null; then
    pgrep -x dunst && notify-send "$chosen desmontado correctamente"
else
    pgrep -x dunst && notify-send -u critical "error" "No se pudo desmontar $chosen (quizá ocupado)"
fi

exit 0
