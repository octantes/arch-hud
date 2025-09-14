#!/usr/bin/env bash

# playerctl loop ensures that when a track is skipped in the music player itself, it still updates on bar
pidof -x playerctl-loop >/dev/null 2>&1 || playerctl-loop >/dev/null 2>&1 &

# format state to alternate between artist - title and album - title
FORMAT_FILE="/tmp/dwmblocks_mus_format"
[ ! -f "$FORMAT_FILE" ] && echo "0" > "$FORMAT_FILE"
read FORMAT < "$FORMAT_FILE"

# priority is: if browser or mpv are playing, they will display. otherwise, mpd displays, playing or paused.
# browser and mpv should never display if paused.
if [ -z "$MUSIC_PLAYING_PLAYERS" ]; then
	# if MUSIC_PLAYING_PLAYERS is not set, use the default players
	MUSIC_PLAYING_PLAYERS="chromium mpd mpv"
fi

[ "$FORMAT" -eq 0 ] && META="{{ trunc(artist,17) }} - {{ trunc(title,17) }}" || META="{{ trunc(album,17) }} - {{ trunc(title,17) }}"

for PLAYER in $MUSIC_PLAYING_PLAYERS; do
# if the player is not playing, continue to the next player, until we find one that is playing
	[ "$(playerctl --player=$PLAYER status 2>/dev/null)" != "Playing" ] && continue
		ICON="r "
		echo "$ICON"$(playerctl metadata --player $PLAYER --format "$META")
done

# just display what's paused in mpd, in case nothing is playing
ICON="p"
echo "$ICON"
# echo "$ICON"$(playerctl metadata --player mpd --format "$META")


case $BLOCK_BUTTON in
		1) echo "$(( ($FORMAT + 1) % 2 ))" > "$FORMAT_FILE" ;;
		2) playerctl --player mpd play-pause; pkill -RTMIN+11 "${STATUSBAR:-dwmblocks}" ;;
		3) setsid -w -f "$TERMINAL" -e pulsemixer; pkill -RTMIN+11 "${STATUSBAR:-dwmblocks}" ;;
		4) amixer -D pulse sset Master 10%+ ;;
		5) amixer -D pulse sset Master 10%- ;;
		6) setsid -f "$TERMINAL" -e "$EDITOR" "$0" ;;
esac
