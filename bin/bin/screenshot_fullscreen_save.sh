#!/bin/sh

dir=~/workspace/screenshots
current=$(date +%F_%H-%M-%S)

mkdir -p "$dir"

resolution=$(xdpyinfo | awk '/dimensions/{print $2}')
shotgun -g "$resolution+0+0" -f png "${dir}/${current}"
notify-send "Shotgun" "Screenshot ${current} saved."
