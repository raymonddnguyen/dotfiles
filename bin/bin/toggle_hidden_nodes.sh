#!/bin/sh
hide_nodes() {
    local CURRENT_DESKTOP=$(bspc query -D -d);
    local TILED_NODES=$(bspc query -N -n .tiled -d $CURRENT_DESKTOP);

    for node in $TILED_NODES; do
        bspc node $node -g hidden=on;
    done
}

show_nodes() {
    local CURRENT_DESKTOP=$(bspc query -D -d);
    local HIDDEN_NODES=$(bspc query -N -n .hidden -d $CURRENT_DESKTOP)

    for node in $HIDDEN_NODES; do
        bspc node $node -g hidden=off;
    done
}

case $1 in
    show)
        show_nodes
        ;;
    hide)
        hide_nodes
        ;;
esac
