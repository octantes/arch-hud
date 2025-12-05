#!/usr/bin/env bash

# to import replace results

CONFIG_DIR="$HOME/.config/mclauncher/instances/1.21.10/minecraft/saves"
DEST_DIR="/home/havitat/02/A2/archivo"
ARCHIVE_NAME="mcsaves.tar"

tar -cf "$DEST_DIR/$ARCHIVE_NAME" -C "$CONFIG_DIR" .

echo "mc saves config exported to: $DEST_DIR/$ARCHIVE_NAME"
