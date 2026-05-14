#!/usr/bin/env bash

export PATH="/home/cadenas/.arch/crypts:$PATH"                                          # set script directory
export WEBKIT_DISABLE_COMPOSITING_MODE=1                                                # disable compositing for surf
export XCURSOR_SIZE=8                                                                   # set cursor size for x11
export XDG_CURRENT_DESKTOP=GNOME                                                        # set gtk backend

[ -f /home/kaste/.bashrc ] && . /home/kaste/.bashrc                                     # load bash config

# init dbus

[ -z "$DBUS_SESSION_BUS_ADDRESS" ] && eval $(dbus-launch --sh-syntax --exit-with-session)

if command -v dbus-update-activation-environment >/dev/null 2>&1; then
    dbus-update-activation-environment --systemd DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP
fi

xrdb -merge ~/Xresources                                                                # update settings (cursor)
xsetroot -solid "#100F0F"                                                               # set background color
xset -dpms                                                                              # disable screen sleep
xset s off                                                                              # disable screen sleep
autorandr --change workstation                                                          # apply display settings

xrandr --output HDMI-0 --mode 1920x1080 --rate 74.97                                    # main monitor settings
xrandr --output DP-3 --mode 1920x1080 --rate 60.00 --rotate right --left-of HDMI-0      # left monitor settings

pgrep -x mpd > /dev/null || mpd --no-daemon ~/.config/mpd/mpd.conf &                    # init music server
dunst &                                                                                 # init notification manager
dwmblocks &                                                                             # init statusbar commands

# init dwm infinite loop with lock file

rm -f /tmp/dwm.lock

while [ ! -f /tmp/dwm.lock ]; do
    dwm > /dev/null 2>&1
done

rm -f /tmp/dwm.lock
