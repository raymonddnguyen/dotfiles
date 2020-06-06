# Environment Variables
export ZSH="$HOME/.oh-my-zsh"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export LANG=en_US.UTF-8
export NEOFETCH_IMAGE_DIR="$HOME/workspace/neofetch_images"
export WALLPAPER_DIR="$HOME/workspace/wallpapers"
export TERMINAL="kitty --config ~/.config/kitty/kitty_bspwm.conf"

# Note: Need to edit $ZSH/lib/history.zsh if using oh-my-zsh
export HISTFILESIZE=5000000
export HISTSIZE=5000000
export HISTTIMEFORMAT="%Y-%m-%dT%H:%M:%S "
export SAVEHIST=$HISTSIZE

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi

# Add anaconda to path
export PATH="$PATH:$HOME/anaconda3/bin"  # commented out by conda initialize

# Add additional scripts if ~/bin exists
if [ -d "$HOME/bin" ] ; then
    export PATH="$PATH:$HOME/bin"
fi

# Set XDG config home
export XDG_CONFIG_HOME="$HOME/.config"

# FZF customizations (Dependencies: fd, bat, tree)
export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --info=hidden --border --preview-window 'right:60%' --preview '([[ -d {} ]] && tree -aC {}) || ([[ -f {} ]] && bat --color=always --style=header,grid --line-range :300 {})'"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
export FZF_CTRL_T_COMMAND='fd --hidden --follow --exclude .git'
export FZF_CTRL_T_OPTS="--ansi --preview-window 'right:60%' --preview '([ -d {} ] && tree -aC {}) || ([ -f {} ] && bat --color=always --style=header,grid --line-range :300 {})'"

# For fzf completion and keybindings (oh-my-zsh)
export FZF_BASE=/usr/local/bin/fzf
