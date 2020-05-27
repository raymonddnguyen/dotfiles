# Need to source .zprofile for some display managers like lightdm
if [ "$SHELL" = "/usr/bin/zsh" ]; then
    . ~/.zprofile
    return
fi
