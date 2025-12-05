#!/usr/bin/env bash

geom=$(slop -f "%x %y %w %h") || exit 1
read -r X Y W H <<< "$geom"

ffmpeg -f x11grab -video_size "${W}x${H}" -i ":0.0+${X},${Y}" -t 10 \
  -c:v libx264 -preset veryfast -crf 23 ~/screencap.mp4
