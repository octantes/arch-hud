[[ $- != *i* ]] && return # do nothing if not running interactively
export PATH="$HOME/.local/bin:$PATH"

# SET ENV -----------------------------------------------------------------

export VISUAL=nvim;
export EDITOR=nvim;

# SET STYLES --------------------------------------------------------------

eval "$(dircolors -b ~/.dircolors)"

# SET ALIASES -------------------------------------------------------------

PS1='[\u@\h \W]\$ '

alias sudo='sudo env "PATH=$PATH"'                           # sudo inherits path

export A=/home/archivo
export C=/home/cadenas
export H=/home/havitat
export K=/home/kaste
export M=/home/mounts

alias @a='cd /home/archivo'
alias @c='cd /home/cadenas'
alias @h='cd /home/havitat'
alias @k='cd /home/kaste'
alias @m='cd /home/mounts'

alias @ac='cd /home/cadenas/.arch/crypts'
alias @ar='cd /home/cadenas/.arch'

alias lf='ranger'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias remote='ssh -Xf workstation'

# PATHS TO .CONFIG --------------------------------------------------------

export PATH="/home/cadenas/.arch/crypts:$PATH"               # set scripts

export PATH=$PATH:/usr/local/bin                             # set dwmblocks
export XDG_CONFIG_HOME="$HOME/.config"                       # set home
export XDG_CACHE_HOME="$HOME/.cache"                         # set cache
export XDG_DATA_HOME="$HOME/.local/share"                    # set data
export XDG_STATE_HOME="$HOME/.local/state"                   # set state
export RUSTUP_HOME="$HOME/.config/rustup"                    # set rustup
export CARGO_HOME="$HOME/.config/cargo"                      # set cargo
export PATH="$CARGO_HOME/bin:$PATH"                          # set cargo
[ -s "$CARGO_HOME/env" ] && \. "$CARGO_HOME/env"             # set env
export STEAM_HOME="$HOME/.config/steam"                      # set steam
export GNUPGHOME="$HOME/.config/gnupg"                       # set gpg

# NVIDIA TO XDG -----------------------------------------------------------

export __GL_SHADER_DISK_CACHE_PATH="$XDG_CACHE_HOME/nv"
mkdir -p "$__GL_SHADER_DISK_CACHE_PATH"

# NVM TO XDG --------------------------------------------------------------

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# NPM TO XDG --------------------------------------------------------------

export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"

mkdir -p "$XDG_CONFIG_HOME/npm"
if [ ! -f "$NPM_CONFIG_USERCONFIG" ]; then
    echo "prefix=$XDG_DATA_HOME/npm" > "$NPM_CONFIG_USERCONFIG"
fi

export PATH="$XDG_DATA_HOME/npm/bin:$PATH"

# SECRETS -----------------------------------------------------------------

[ -f ~/.secrets ] && source ~/.secrets

if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" >/dev/null 2>&1
fi
