#!/usr/bin/env bash
set -euo pipefail

# 1. Suppress the harmless slop OpenGL warning so it doesn't clutter your terminal
geom=$(slop -f "%x %y %w %h" 2>/dev/null) || { notify-send "recording" "selection cancelled"; exit 1; }
read -r X Y W H <<< "$geom"

if ! [[ "$W" =~ ^[0-9]+$ ]] || ! [[ "$H" =~ ^[0-9]+$ ]] || [ "$W" -le 0 ] || [ "$H" -le 0 ]; then
  notify-send "recording" "invalid selection"
  exit 1
fi

ts=$(date +%H%M%S)
out="$HOME/screencap-$ts.mp4"
log="/tmp/screencap-error.log"

notify-send "recording" "recording the next ten video seconds"

# 2. Fix the scale filter: trunc(iw/2)*2:trunc(ih/2)*2 forces both width and height to be even
# 3. Log errors to a file instead of /dev/null
if ffmpeg -f x11grab -video_size "${W}x${H}" -i ":0.0+${X},${Y}" -t 10 \
  -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" \
  -c:v libx264 -preset veryfast -pix_fmt yuv420p -crf 23 \
  -y "$out" > "$log" 2>&1 && [ -s "$out" ]; then
  
  notify-send "recording" "saved $out"
  
else
  rm -f "$out"
  notify-send "recording" "recording failed"
  echo "ffmpeg failed. Crash log:"
  cat "$log"
  exit 1
fi
