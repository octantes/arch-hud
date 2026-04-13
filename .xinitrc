#!/usr/bin/env bash

export PATH="/home/cadenas/.arch/crypts:$PATH"

export WEBKIT_DISABLE_COMPOSITING_MODE=1 # disable compositing for surf
export XCURSOR_SIZE=8                    # set cursor size for x11

Xcursor.size: 8

. /home/kaste/.bashrc

if ! pgrep -x mpd > /dev/null; then
    mpd --no-daemon ~/.config/mpd/mpd.conf &     # run music server
fi

xsetroot -solid "#100F0F"

xset -dpms   # disable screen sleep
xset s off   # disable screen sleep

autorandr --change workstation   # apply display settings
xrdb -merge ~/Xresources         # update settings (cursor)

dunst &              # runs notification manager
dwmblocks &          # runs statusbar commands

xrandr --output HDMI-0 --mode 1920x1080 --rate 74.97
xrandr --output DP-3 --mode 1920x1080 --rate 60.00 --rotate right --left-of HDMI-0

# run windows manager

while true; do
	dwm
done
