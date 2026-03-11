#!/bin/bash
cd "$(dirname "$0")"
npx serve -p 3000 . &
sleep 2
xdg-open http://localhost:3000
