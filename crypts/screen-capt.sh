#!/usr/bin/env bash

geom=$(slop -f "%x %y %w %h") || exit 1
read -r X Y W H <<< "$geom"

notify-send "recording" "recording the next ten video seconds" 2>/dev/null

ffmpeg -f x11grab -video_size "${W}x${H}" -i ":0.0+${X},${Y}" -t 10 \
  -vf "scale=-2:ih" \
  -c:v libx264 -preset veryfast -pix_fmt yuv420p -crf 23 \
  -y ~/screencap.mp4
