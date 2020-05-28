# Environment Variables
export ZSH="$HOME/.oh-my-zsh"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export LANG=en_US.UTF-8
export HISTFILESIZE=500000000
export HISTSIZE=50000000
export HISTTIMEFORMAT="%Y-%m-%dT%H:%M:%S "

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

# FZF customizations
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'    # Searches everything
export FZF_DEFAULT_OPTS='--height=40% --layout=reverse --info=hidden --border'
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"

# For fzf completion and keybindings (oh-my-zsh)
export FZF_BASE=/usr/local/bin/fzf
