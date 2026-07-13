#!/usr/bin/env bash
set -euo pipefail

geom=$(slop -f "%x %y %w %h") || { notify-send "recording" "selection cancelled"; exit 1; }
read -r X Y W H <<< "$geom"

if ! [[ "$W" =~ ^[0-9]+$ ]] || ! [[ "$H" =~ ^[0-9]+$ ]] || [ "$W" -le 0 ] || [ "$H" -le 0 ]; then
  notify-send "recording" "invalid selection"
  exit 1
fi

ts=$(date +%H%M%S)
out="$HOME/screencap-$ts.mp4"

notify-send "recording" "recording the next thirty video seconds"

if ffmpeg -f x11grab -video_size "${W}x${H}" -i ":0.0+${X},${Y}" -t 30 \
  -vf "scale=-2:ih" \
  -c:v libx264 -preset veryfast -pix_fmt yuv420p -crf 23 \
  -y "$out" 2>/dev/null && [ -s "$out" ]; then
  notify-send "recording" "saved $out"
else
  rm -f "$out"
  notify-send "recording" "recording failed"
  exit 1
fi
