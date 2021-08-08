#!/bin/sh

# IMPORTANT: Install dunstify and faba-icon-theme from AUR
# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute
icon_path="/usr/share/icons/Faba/48x48/notifications/"

function get_volume {
    amixer -D pulse get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
    amixer -D pulse get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
    local volume=$( get_volume )
    local padlimit=8

    # Set icon
    if [ "$volume" -ge 80 ]; then
        icon_name="${icon_path}notification-audio-volume-high.svg"
    elif [ "$volume" -ge 20 ]; then
        icon_name="${icon_path}notification-audio-volume-medium.svg"
    elif [ "$volume" -gt 0 ]; then
        icon_name="${icon_path}notification-audio-volume-low.svg"
    else
        icon_name="${icon_path}notification-audio-volume-muted.svg"
    fi

    local bar=$(seq -s "─" 0 $(($volume/ 5)) | sed 's/[0-9]//g')
    local formatted_line=$(printf "%-*s%s" $((${padlimit} - ${#volume})) "$volume" "$bar")

    # Send the notification
    if [ "$volume" != 0 ]; then
        dunstify "$formatted_line" -i "$icon_name" -t 2000 -h int:value:"$volume" -h string:synchronous:"$bar" --replace=555
    else
        dunstify "$volume" -i "$icon_name" -t 2000 -h int:value:"$volume" --replace=555
    fi
}

case $1 in
    up)
        # Set the volume on (if it was muted)
        amixer -D pulse set Master on > /dev/null
        # Up the volume (+ 5%)
        amixer -D pulse sset Master 5%+ > /dev/null
        send_notification
        ;;
    down)
        amixer -D pulse set Master on > /dev/null
        amixer -D pulse sset Master 5%- > /dev/null
        send_notification
        ;;
    mute)
        # Toggle mute
        amixer -D pulse set Master 1+ toggle > /dev/null
        if is_mute ; then
            dunstify -i "${icon_path}notification-audio-volume-muted.svg" --replace=555 -u normal "Mute" -t 2000
        else
            send_notification
        fi
        ;;
esac
