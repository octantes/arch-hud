#!/usr/bin/env bash

# to import replace results

cp ~/.config/mpd/mpd.conf ~/.config/rmpc/

CONFIG_DIR="$HOME/.config/rmpc"
DEST_DIR="$HOME/arch-hud"
ARCHIVE_NAME="x rmpc.tar"

tar -cf "$DEST_DIR/$ARCHIVE_NAME" -C "$CONFIG_DIR" .

echo "rmpc + mpd config exported to: $DEST_DIR/$ARCHIVE_NAME"
