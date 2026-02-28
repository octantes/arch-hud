#!/usr/bin/env bash

targets="dmenu dwm dwmblocks st surf tabbed"

for t in $targets; do
    if [ -d "$t" ]; then
        cd "$t" || exit 1
        sudo make clean install
        cd ..
    fi
done
