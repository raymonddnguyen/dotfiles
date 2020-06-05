#!/bin/sh -e

dir=~/workspace/screenshots
current=$(date +%F_%H-%M-%S)

mkdir -p "$dir"

# Need the sleep because shotgun will screenshot a dimmed area elsewise
selection=$(hacksaw -f "-i %i -g %g")
sleep 0.25
shotgun $selection -f png "${dir}/${current}"
notify-send "Shotgun" "Screenshot ${current} saved."
