#!/usr/bin/env bash

cd "$(dirname "$0")/../fonts"

# find matches in subfolders, ignore case, remove leading './', wrap in quotes, join with commas
FILES=$(find . -type f \( -iname "*.ttf" -o -iname "*.otf" -o -iname "*.woff" -o -iname "*.woff2" \) | sed 's|^\./||' | sed 's/.*/"&"/' | tr '\n' ',' | sed 's/,$//' | sed 's/.*/[&]/')

# handle empty directories
if [ "$FILES" == "" ] || [ "$FILES" == "[]" ]; then FILES="[]"; fi

# template font data injection
sed "s|/\* DATA_PLACEHOLDER \*/|$FILES|g" fonts-template.html > fonts.html

echo "fonts indexed!"
