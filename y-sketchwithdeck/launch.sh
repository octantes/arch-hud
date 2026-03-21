#!/usr/bin/env bash

cd "$(dirname "$0")"

if lsof -t -i:3000 >/dev/null 2>&1; then
    notify-send "deck" "port is occupied - cleaning up..."
    kill -9 $(lsof -t -i:3000)
    sleep 1
fi

notify-send "deck" "starting server..."
npx serve -p 3000 . &
sleep 2
xdg-open http://localhost:3000
