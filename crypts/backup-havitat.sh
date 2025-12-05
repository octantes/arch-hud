#!/usr/bin/env bash

# to import replace results

SOURCE_DIR="/home/havitat"
DEST_DIR="/home/archivo"

YEAR=$(date +%y)
MONTH=$(date +%m)

ARCHIVE_NAME="H${YEAR}${MONTH}.tar"

tar -cf "$DEST_DIR/$ARCHIVE_NAME" --absolute-names --acls --xattrs --xattrs-include='*' --preserve-permissions --same-owner --numeric-owner -C / "${SOURCE_DIR#/}"

echo "havitat backup exported to: $DEST_DIR/$ARCHIVE_NAME"
