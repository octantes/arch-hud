#!/usr/bin/env bash

# to import replace results

CONFIG_DIR="$HOME/.config/dunst"
DEST_DIR="$HOME/arch-hud"
ARCHIVE_NAME="x dunst.tar"

tar -cf "$DEST_DIR/$ARCHIVE_NAME" -C "$CONFIG_DIR" .

echo "dunst config exported to: $DEST_DIR/$ARCHIVE_NAME"
