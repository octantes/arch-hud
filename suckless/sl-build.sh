#!/usr/bin/env bash
set -e

targets="dmenu dwm blocks st surf tabbed"

for t in $targets; do
    if [ -d "$t" ]; then
        cd "$t" || exit 1
        sudo make clean install
        cd ..
    fi
done
