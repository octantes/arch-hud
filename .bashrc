[[ $- != *i* ]] && return # do nothing if not running interactively

# SET ENV -------------------------------------------------------

export VISUAL=nvim;
export EDITOR=nvim;

# SET STYLES ----------------------------------------------------

eval "$(dircolors -b ~/.dircolors)"

# SET ALIASES ---------------------------------------------------

export A=/home/archivo
export K=/home/kaste
export H=/home/havitat
export M=/home/mounts

alias @a='cd /home/archivo'
alias @k='cd /home/kaste'
alias @h='cd /home/havitat'
alias @m='cd /home/mounts'

alias @shs='cd /home/kaste/arch-hud/crypts/'
alias @hud='cd /home/kaste/arch-hud/'

alias lf='ranger'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='[\u@\h \W]\$ '

# PATHS TO .CONFIG ----------------------------------------------

export PATH="/home/kaste/arch-hud/crypts:$PATH"   # set scripts

export PATH=$PATH:/usr/local/bin                  # for dwmblocks
export XDG_CONFIG_HOME="$HOME/.config"            # set home
export XDG_DATA_HOME="$HOME/.config"              # set data
export CARGO_HOME="$HOME/.config/cargo"           # set cargo
export RUSTUP_HOME="$HOME/.config/rustup"         # set rustup
export PATH="$CARGO_HOME/bin:$PATH"               # set cargo
export STEAM_HOME="$HOME/.config/steam"           # set steam
[ -s "$CARGO_HOME/env" ] && \. "$CARGO_HOME/env"  # set cargo env

# NVM TO XDG ----------------------------------------------------

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# NPM TO XDG ----------------------------------------------------

export NPM_CONFIG_USERCONFIG="$HOME/.config/npm/npmrc"
export NPM_CONFIG_CACHE="$HOME/.config/npm/cache"
mkdir -p "$HOME/.config/npm"
[ -f "$NPM_CONFIG_USERCONFIG" ] || touch "$NPM_CONFIG_USERCONFIG"
