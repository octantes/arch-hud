#!/usr/bin/env bash

cd "$(dirname "$0")"

if lsof -t -i:3000 >/dev/null; then
    notify-send "port is occupied - cleaning up..."
    kill -9 $(lsof -t -i:3000)
    sleep 1
fi

nofify-send "starting server..."
npx serve -p 3000 . &
sleep 2
xdg-open http://localhost:3000
