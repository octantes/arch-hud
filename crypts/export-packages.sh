#!/usr/bin/env bash

# to import replace results

DEST_DIR="$HOME/arch-hud"
ARCHIVE_NAME="packages.md"

yay -Qent | sed 's/^/- /' > "$DEST_DIR/$ARCHIVE_NAME"

echo "package log exported to: $DEST_DIR/$ARCHIVE_NAME"
