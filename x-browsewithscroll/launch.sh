#!/usr/bin/env bash

# get directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

echo "initializing browsewithscroll!"

chmod +x scripts/init-dirs.sh
./scripts/init-dirs.sh

echo "opening in browser..."

# Open index.html based on Operating System
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    xdg-open index.html
elif [[ "$OSTYPE" == "darwin"* ]]; then
    open index.html
elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    start index.html
else
    echo "couldn't detect browser launcher, please open index.html manually!"
fi
