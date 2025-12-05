#!/usr/bin/env bash

# to import replace results

CONFIG_DIR="$HOME/.config/obs-studio"
DEST_DIR="/home/havitat/02/C8/archivo"
ARCHIVE_NAME="obs.tar"

tar -cf "$DEST_DIR/$ARCHIVE_NAME" -C "$CONFIG_DIR" .

echo "obs config exported to: $DEST_DIR/$ARCHIVE_NAME"
