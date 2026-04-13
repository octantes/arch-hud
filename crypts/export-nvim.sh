#!/usr/bin/env bash

# to import replace results

CONFIG_DIR="$HOME/.config/nvim"
DEST_DIR="$HOME/cadenas/.arch"
ARCHIVE_NAME="nvim.tar"

tar -cf "$DEST_DIR/$ARCHIVE_NAME" -C "$CONFIG_DIR" .

echo "nvim config exported to: $DEST_DIR/$ARCHIVE_NAME"
