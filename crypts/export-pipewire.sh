#!/usr/bin/env bash

# to import replace results

CONFIG_DIR="$HOME/.config/pipewire"
DEST_DIR="$HOME/arch-hud"
ARCHIVE_NAME="x pipewire.tar"

tar -cf "$DEST_DIR/$ARCHIVE_NAME" -C "$CONFIG_DIR" .

echo "pipewire config exported to: $DEST_DIR/$ARCHIVE_NAME"
