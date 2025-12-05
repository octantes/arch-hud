#!/usr/bin/env bash

# to import replace results

CONFIG_DIR="$HOME/arch-hud"
DEST_DIR="/home/havitat/04"
ARCHIVE_NAME="arch.tar"

tar -cf "$DEST_DIR/$ARCHIVE_NAME" -C "$CONFIG_DIR" .

echo "arch config exported to: $DEST_DIR/$ARCHIVE_NAME"
