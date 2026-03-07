#!/usr/bin/env bash

cd "$(dirname "$0")"

echo "starting asset sync..."

chmod +x init-fonts.sh
chmod +x init-media.sh

./init-fonts.sh
./init-media.sh

echo "all lists up to date!"
