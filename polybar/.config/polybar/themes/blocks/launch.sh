#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# polybar -rq dummy &
# polybar -rq music &
polybar tray -c ~/.config/polybar/themes/blocks/config &
polybar misc -c ~/.config/polybar/themes/blocks/config &
polybar bspwm -c ~/.config/polybar/themes/blocks/config &

# 2nd monitor for external
# dp_1=$(eval "xrandr --query | rg 'DP-1 connected 2560'")
# echo "$dp_1"
thunderbolt_dir=/sys/devices/pci0000:00/0000:00:1d.4/0000:03:00.0/0000:04:00.0/0000:05:00.0/domain0/0-0/0-1
# if [[ $dp_1 == *"connected"* ]]; then
if [[ -d $thunderbolt_dir ]]; then
    if xrandr -q | rg -i 'dp-2 connected 1440' &>/dev/null; then
        polybar trayvertical -c ~/.config/polybar/themes/blocks/config &
        polybar bspwmvertical -c ~/.config/polybar/themes/blocks/config &

        polybar misclaptop -c ~/.config/polybar/themes/blocks/config &
        polybar traylaptop -c ~/.config/polybar/themes/blocks/config &
        polybar bspwmlaptop -c ~/.config/polybar/themes/blocks/config &
    else
        polybar misc2 -c ~/.config/polybar/themes/blocks/config &
        polybar tray2 -c ~/.config/polybar/themes/blocks/config &
        polybar bspwm2 -c ~/.config/polybar/themes/blocks/config &
    fi
fi

echo "Polybar launched..."
