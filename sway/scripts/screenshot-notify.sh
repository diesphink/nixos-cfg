#!/bin/sh

set -e
DIR=$HOME/Pictures/screenshots/2024

while true; do
    mkdir -p "$DIR" && inotifywait -q -e create "$DIR" --format '%w%f' | xargs notify-send "Screenshot saved" --category "hud"
done
