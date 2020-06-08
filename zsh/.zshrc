# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# pywal
eval "set -- $(sed 1d "$HOME/.fehbg")"
wal -i $4 > /dev/null 2>&1

# If not in a tmux session, run neofetch
if ! { [ "$TERM" = "screen-256color" ] && [ -n "$TMUX" ]; } then
    # Neofetch with image
    random_image=$(ls $NEOFETCH_IMAGE_DIR | shuf -n 1)
    neofetch --source "$NEOFETCH_IMAGE_DIR/$random_image" --size 270px
fi

# Completion for kitty
autoload -Uz compinit
compinit
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="random"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode fzf)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

# Updates editor information when the keymap changes.
function zle-line-init zle-keymap-select {
    #RPS1="${${KEYMAP/vicmd/[normal]}/(main|viins)/[insert]}"
    #RPS2=$RPS1
    #echo -ne '\e[5 q'
    zle reset-prompt

    # Displays bar when in normal mode, and beam when in insert mode
    if [[ "$KEYMAP" == "main" || "$KEYMAP" == "viins" ]]; then
        echo -ne '\e[5 q'
    elif [[ "$KEYMAP" == 'vicmd' ]]; then
        echo -ne '\e[2 q'
    fi
}

zle -N zle-line-init
zle -N zle-keymap-select

# Enable copy paste in vi-mode Note: requires xsel installed
vi-append-x-selection () { RBUFFER=$(xsel -o -p </dev/null)$RBUFFER; }
zle -N vi-append-x-selection
bindkey -a '^X' vi-append-x-selection
vi-yank-x-selection () { print -rn -- $CUTBUFFER | xsel -i -p; }
zle -N vi-yank-x-selection
bindkey -a '^Y' vi-yank-x-selection

# Plugins
source /usr/share/zsh/scripts/zplug/init.zsh
zplug "b4b4r07/zsh-vimode-visual"

zplug load
bindkey -M vicmd 'V'  vi-vlines-mode
bindkey -M vicmd 'v'  vi-visual-mode
bindkey -M vivis ' '  vi-visual-forward-char
bindkey -M vivis ','  vi-visual-rev-repeat-find
bindkey -M vivis '0'  vi-visual-bol
bindkey -M vivis ';'  vi-visual-repeat-find
bindkey -M vivis 'B'  vi-visual-backward-blank-word
bindkey -M vivis 'C'  vi-visual-substitute-lines
bindkey -M vivis 'D'  vi-visual-kill-and-vicmd
bindkey -M vivis 'E'  vi-visual-forward-blank-word-end
bindkey -M vivis 'F'  vi-visual-find-prev-char
bindkey -M vivis 'G'  vi-visual-goto-line
bindkey -M vivis 'I'  vi-visual-insert-bol
bindkey -M vivis 'J'  vi-visual-join
bindkey -M vivis 'O'  vi-visual-exchange-points
bindkey -M vivis 'R'  vi-visual-substitute-lines
bindkey -M vivis 'S ' vi-visual-surround-space
bindkey -M vivis "S'" vi-visual-surround-squote
bindkey -M vivis 'S"' vi-visual-surround-dquote
bindkey -M vivis 'S(' vi-visual-surround-parenthesis
bindkey -M vivis 'S)' vi-visual-surround-parenthesis
bindkey -M vivis 'T'  vi-visual-find-prev-char-skip
bindkey -M vivis 'U'  vi-visual-uppercase-region
bindkey -M vivis 'V'  vi-visual-exit-to-vlines
bindkey -M vivis 'W'  vi-visual-forward-blank-word
bindkey -M vivis 'Y'  vi-visual-yank
bindkey -M vivis '^M' vi-visual-yank
bindkey -M vivis '^[' vi-visual-exit
bindkey -M vivis 'b'  vi-visual-backward-word
bindkey -M vivis 'c'  vi-visual-change
bindkey -M vivis 'd'  vi-visual-kill-and-vicmd
bindkey -M vivis 'e'  vi-visual-forward-word-end
bindkey -M vivis 'f'  vi-visual-find-next-char
bindkey -M vivis 'gg' vi-visual-goto-first-line
bindkey -M vivis 'h'  vi-visual-backward-char
bindkey -M vivis 'j'  vi-visual-down-line
bindkey -M vivis 'jj' vi-visual-exit
bindkey -M vivis 'k'  vi-visual-up-line
bindkey -M vivis 'l'  vi-visual-forward-char
bindkey -M vivis 'o'  vi-visual-exchange-points
bindkey -M vivis 'p'  vi-visual-put
bindkey -M vivis 'r'  vi-visual-replace-region
bindkey -M vivis 't'  vi-visual-find-next-char-skip
bindkey -M vivis 'u'  vi-visual-lowercase-region
bindkey -M vivis 'v'  vi-visual-eol
bindkey -M vivis 'w'  vi-visual-forward-word
bindkey -M vivis 'y'  vi-visual-yank

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ls='exa'
alias neomutt='neomutt; cat /home/raymond/.cache/wal/sequences'
alias ranger='ranger; cat /home/raymond/.cache/wal/sequences'
#alias cat='bat'
alias mv='mv -i'
alias code='vscodium'
alias open='xdg-open'
alias t='todo.sh'
alias kill-true-orphans="sudo pacman -Rns $(pacman -Qtdq)"

# Use nvim instead of vim when available
if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

# powerlevel 10k
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# fzf completion and keybindings (make sure this is after vi-mode)
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# zsh auto-suggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zsh syntax highlighting
# zsh-syntax-highlighting.zsh wraps ZLE widgets. It must be sourced after all custom widgets have been created (i.e., after all zle -N calls and after running compinit)
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
