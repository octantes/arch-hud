#!/usr/bin/env bash

# to import replace results

CONFIG_DIR="$HOME/.config/pipewire"
DEST_DIR="/home/cadenas/.arch"
ARCHIVE_NAME="pipewire.tar"

tar -cf "$DEST_DIR/$ARCHIVE_NAME" -C "$CONFIG_DIR" .

echo "pipewire config exported to: $DEST_DIR/$ARCHIVE_NAME"
