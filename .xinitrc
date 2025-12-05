#!/usr/bin/env bash

export PATH="/home/kaste/arch-hud/crypts:$PATH"

export WEBKIT_DISABLE_COMPOSITING_MODE=1 # disable compositing for surf
export XCURSOR_SIZE=8                    # set cursor size for x11

. /home/kaste/.bashrc

if ! pgrep -x mpd > /dev/null; then
    mpd --no-daemon ~/.config/mpd/mpd.conf &     # run music server
fi

xrandr --output HDMI-0 --mode 1920x1080 --rate 74.97
xrandr --output DP-2 --mode 1600x900 --rate 60.00 --rotate right

xsetroot -solid "#986C98"

xset -dpms   # disable screen sleep
xset s off   # disable screen sleep

autorandr --change workstation   # apply display settings
xrdb -merge ~/Xresources         # update settings (cursor)

dunst &              # runs notification manager
dwmblocks &          # runs statusbar commands

# run windows manager

while true; do
	dwm
done
