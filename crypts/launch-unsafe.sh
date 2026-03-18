#!/usr/bin/env bash

unshare -rn chromium --no-sandbox --disable-web-security --allow-file-access-from-files --app="file:///ruta/a/tu/dashboard.html" --user-data-dir=/tmp/scavenger-runtime
