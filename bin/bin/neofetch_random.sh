#!/bin/sh

# Neofetch with image
random_image=$(ls ~/workspace/neofetch_images/ | shuf -n 1)
neofetch --source "$HOME/workspace/neofetch_images/$random_image" --size 270px 
