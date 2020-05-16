current=$(date +%F_%H-%M-%S)

hacksaw -n | {
    IFS=+x read -r w h x y

    w=$((w + w % 2))
    h=$((h + h % 2))

    byzanz-record        \
        -w "${w}"        \
        -h "${h}"        \
        -x "${x}"        \
        -y "${y}"        \
        -d 10            \
        "$HOME/workspace/gifs/$current.gif"
}
