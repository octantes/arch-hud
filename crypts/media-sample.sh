#!/usr/bin/env bash

DURATION="00:01:00"
OUTPUT_DIR="$HOME"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
FILE_NAME="$OUTPUT_DIR/$TIMESTAMP.mp3"

notify-send "recording" "recording the next audio minute" 2>/dev/null
ffmpeg -f pulse -i default -t "$DURATION" -acodec libmp3lame -ab 192k "$FILE_NAME" -loglevel quiet
