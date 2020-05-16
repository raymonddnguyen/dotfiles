#!/bin/sh
#
# record - record an area of the screen

dir=~/workspace/videos/
current=$(date +%F_%H-%M-%S)

mkdir -p "$dir"

hacksaw -n | {
    IFS=+x read -r w h x y

    w=$((w + w % 2))
    h=$((h + h % 2))

    ffmpeg               \
        -v 16            \
        -r 30            \
        -f x11grab       \
        -s "${w}x${h}"   \
        -i ":0.0+$x,$y"  \
        -preset slow     \
        -c:v h264        \
        -pix_fmt yuv420p \
        -crf 20          \
        -timelimit 10    \
        "$dir/$current.mp4"
}
