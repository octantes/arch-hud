#!/usr/bin/env bash

# to import replace results

CONFIG_DIR="$HOME/.config/GIMP/3.0"
DEST_DIR="/home/havitat/02/S7/archivo"
ARCHIVE_NAME="gimp.tar"

tar -cf "$DEST_DIR/$ARCHIVE_NAME" -C "$CONFIG_DIR" .

echo "gimp config exported to: $DEST_DIR/$ARCHIVE_NAME"
