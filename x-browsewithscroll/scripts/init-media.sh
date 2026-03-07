#!/usr/bin/env bash

cd "$(dirname "$0")/../media"

EXT="jpg|jpeg|png|gif|webp|mp4|webm|mov|ogg"

# find all files recursively, filter by extension (case-insensitive), remove leading './'
FILES=$(find . -type f | grep -Ei "\.($EXT)$" | sed 's|^\./||' | sed 's/.*/"&"/' | tr '\n' ',' | sed 's/,$//' | sed 's/.*/[&]/')

# handle empty directories
if [ "$FILES" == "" ] || [ "$FILES" == "[]" ]; then FILES="[]"; fi

# template media data injection
sed "s|/\* DATA_PLACEHOLDER \*/|$FILES|g" media-template.html > media.html

echo "media indexed!"
