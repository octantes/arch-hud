[[ $- != *i* ]] && return # do nothing if not running interactively

# SET ENV -----------------------------------------------------------------

export VISUAL=nvim;
export EDITOR=nvim;

# SET STYLES --------------------------------------------------------------

eval "$(dircolors -b ~/.dircolors)"

# SET ALIASES -------------------------------------------------------------

PS1='[\u@\h \W]\$ '

alias sudo='sudo env "PATH=$PATH"'                           # sudo inherits path

export G=/home/agentes
export A=/home/archivo
export K=/home/kaste
export H=/home/havitat
export M=/home/mounts

export O=/home/kaste/.octantes

alias @g='cd /home/agentes'
alias @a='cd /home/archivo'
alias @k='cd /home/kaste'
alias @h='cd /home/havitat'
alias @m='cd /home/mounts'

alias @o='cd /home/kaste/.octantes'

alias @c='cd /home/kaste/.arch/crypts'
alias @h='cd /home/kaste/.arch'

alias lf='ranger'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# PATHS TO .CONFIG --------------------------------------------------------

export PATH="/home/kaste/.arch/crypts:$PATH"             # set scripts

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
export NSS_CONFIG_DIR="$HOME/.config/pki"                    # set pki


# NVM TO XDG --------------------------------------------------------------

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# NPM TO XDG --------------------------------------------------------------

mkdir -p "$HOME/.config/npm"

export NPM_CONFIG_USERCONFIG="$HOME/.config/npm/npmrc"
export NPM_CONFIG_CACHE="$HOME/.config/npm/cache"

[ -f "$NPM_CONFIG_USERCONFIG" ] || touch "$NPM_CONFIG_USERCONFIG"

# SECRETS -----------------------------------------------------------------

[ -f ~/.secrets ] && source ~/.secrets

if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" >/dev/null 2>&1
fi
