#!/bin/sh -e

# Need the sleep because shotgun will screenshot a dimmed area elsewise
selection=$(hacksaw -f "-i %i -g %g")
sleep 0.25
shotgun $selection - | xclip -t 'image/png' -selection clipboard
