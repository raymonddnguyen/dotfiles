#!/bin/sh
resolution=$(xdpyinfo | awk '/dimensions/{print $2}')
shotgun -g "$resolution+0+0" /dev/stdout | xclip -t 'image/png' -selection clipboard
