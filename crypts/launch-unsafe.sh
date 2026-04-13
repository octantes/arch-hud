#!/usr/bin/env bash

unshare -rn chromium --no-sandbox --disable-web-security --allow-file-access-from-files --app="file:///home/cadenas/.arch/z-scrapwithscav/dashboard5.html" --user-data-dir=/tmp/scavenger-runtime
