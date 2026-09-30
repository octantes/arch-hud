#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")"

pidfile=/tmp/screen-rec.pid

# --- Toggle-off: stop an active recording ---
if [ -f "$pidfile" ]; then
    read -r dpid out < "$pidfile" 2>/dev/null || dpid=""
    if [[ "$dpid" =~ ^[0-9]+$ ]] && kill -0 "$dpid" 2>/dev/null && grep -aq x11grab /proc/$dpid/cmdline 2>/dev/null; then
        printf 'q' > /tmp/screen-rec-cmd.fifo 2>/dev/null || true
        notify-send "recording" "stopping..." 2>/dev/null
        for _ in $(seq 1 100); do
            kill -0 "$dpid" 2>/dev/null || break
            sleep 0.1
        done
        kill -0 "$dpid" 2>/dev/null && kill -TERM "$dpid" || true
        if [ -s "$out" ]; then
            notify-send "recording" "saved ${out##*/}" 2>/dev/null
        else
            notify-send "recording" "recording failed" 2>/dev/null
        fi
        rm -f "$pidfile"
        exit 0
    fi
    rm -f "$pidfile"
fi

ts=$(date +%H%M%S)
out="$HOME/screen-rec-$ts.mkv"
log=/tmp/screen-rec.log

# --- Capture geometry: primary monitor, fallback to full root ---
primary=$(xrandr --current 2>/dev/null | awk '/ connected primary / {for (i = 1; i <= NF; i++) if ($i ~ /^[0-9]+x[0-9]+[+-][0-9]+[+-][0-9]+$/) {print $i; exit}}')
if [ -n "$primary" ]; then
    read -r w h ox oy <<< "$(sed -E 's/^([0-9]+)x([0-9]+)([+-][0-9]+)([+-][0-9]+)$/\1 \2 \3 \4/' <<< "$primary")"
else
    size=$(xdpyinfo -display "$DISPLAY" | awk '/dimensions:/ {print $2; exit}')
    w=${size%%x*}
    h=${size#*x}
    ox=0
    oy=0
fi
size="$w"x"$h"

# Full screen with the cursor baked in, lossless, 60 fps.
# stdin is a command FIFO so the stop path can ask ffmpeg to quit
# gracefully ('q'), which reliably writes the mkv trailer.
cmdpipe=/tmp/screen-rec-cmd.fifo
rm -f "$cmdpipe"
mkfifo "$cmdpipe"
exec 9<>"$cmdpipe"
ffmpeg -loglevel error \
    -f x11grab -video_size "$size" -framerate 60 -draw_mouse 1 -i "${DISPLAY}+${ox#+},${oy#+}" \
    -c:v libx264rgb -qp 0 -preset ultrafast -threads 6 -t 7200 -y "$out" \
    <&9 > "$log" 2>&1 &
dpid=$!
renice -n 5 -p "$dpid" >/dev/null 2>&1 || true
taskset -p -c 0-11 "$dpid" >/dev/null 2>&1 || true

echo "$dpid $out" > "$pidfile"

# Liveness guard: only report success once the process survives startup
sleep 0.5
if ! kill -0 "$dpid" 2>/dev/null; then
    notify-send "recording" "recording failed" 2>/dev/null
    kill "$dpid" 2>/dev/null
    rm -f "$pidfile"
    cat "$log"
    exit 1
fi

notify-send "recording" "recording started ($size)" 2>/dev/null