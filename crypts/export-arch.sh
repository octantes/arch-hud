#!/usr/bin/env bash

# to import replace results

CONFIG_DIR="$HOME/arch-hud"
DEST_DIR="/home/havitat/04/archivo"
ARCHIVE_NAME="01 ARCH.tar"

tar -cf "$DEST_DIR/$ARCHIVE_NAME" -C "$CONFIG_DIR" .

echo "arch config exported to: $DEST_DIR/$ARCHIVE_NAME"
