#!/bin/sh

# Neofetch with image
random_image=$(ls $NEOFETCH_IMAGE_DIR | shuf -n 1)
neofetch --source "$NEOFETCH_IMAGE_DIR/$random_image" --size 270px
