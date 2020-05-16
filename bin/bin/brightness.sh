#!/bin/sh

# You can call this script like this:
# $ ./brightness.sh up
# $ ./brightness.sh down

# Script inspired by these wonderful people:
# https://github.com/dastorm/volume-notification-dunst/blob/master/volume.sh
# https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a

function get_brightness {
    xbacklight -get | cut -d '.' -f 1
}

function send_notification {
    local icon="/usr/share/icons/Faba/48x48/notifications/notification-display-brightness.svg"
    local brightness=$(get_brightness)
    local padlimit=8

    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar=$(seq -s "─" 0 $((brightness / 5)) | sed 's/[0-9]//g')
    # Send the notification

    local formatted_line=$(printf "%-*s%s" $((${padlimit} - ${#brightness})) "$brightness" "$bar")
    notify-send.sh -i "$icon" -t 2000 -r 5555 -u normal "$formatted_line"   #-h int:value:"$brightness" -h string:synchronous:"$bar"
}

case $1 in
    up)
        # increase the backlight by 5%
        xbacklight -inc 5
        send_notification
        ;;
    down)
        # decrease the backlight by 5%
        xbacklight -dec 5
        send_notification
        ;;
esac
