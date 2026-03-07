#!/usr/bin/env bash

targets="suckless-dmenu suckless-dwm suckless-blocks suckless-st suckless-surf suckless-tabbed"

for t in $targets; do
    if [ -d "$t" ]; then
        cd "$t" || exit 1
        sudo make clean install
        cd ..
    fi
done
