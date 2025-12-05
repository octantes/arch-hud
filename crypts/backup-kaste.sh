#!/usr/bin/env bash

# to import replace results

SOURCE_DIR="/home/kaste"
DEST_DIR="/home/archivo"

YEAR=$(date +%y)
MONTH=$(date +%m)

ARCHIVE_NAME="K${YEAR}${MONTH}.tar"

tar -cf "$DEST_DIR/$ARCHIVE_NAME" --absolute-names --acls --xattrs --xattrs-include='*' --preserve-permissions --same-owner --numeric-owner -C / "${SOURCE_DIR#/}"

echo "kaste backup exported to: $DEST_DIR/$ARCHIVE_NAME"
