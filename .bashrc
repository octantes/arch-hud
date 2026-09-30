[[ $- != *i* ]] && return # do nothing if not running interactively


# SET ENV -----------------------------------------------------------------

export HOME="/root"
export PATH="/home/kaste/.local/bin:$PATH"

export VSCODE_OSS_SHARED="/home/kaste/.vscode-oss/vscode-oss-shared"
export VISUAL=nvim
export EDITOR=nvim


# SET STYLES --------------------------------------------------------------

eval "$(dircolors -b /root/.dircolors)"


# SET ALIASES -------------------------------------------------------------

PS1='[\u@\h \W]$ '

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
alias @ii='sudo -i'
alias @lf='ranger /home/kaste'

alias lf='ranger'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias remote='ssh -Xf workstation'
alias comfy='sudo -u comfy comfyui --port 8001'
alias nsxiv='nsxiv -p'

# PATHS TO .CONFIG --------------------------------------------------------

export PATH="/home/cadenas/.arch/crypts:$PATH"       # set scripts
export PATH="/usr/local/bin:$PATH"                   # set dwmblocks

# share user's configuration with root
export XDG_CONFIG_HOME="/home/kaste/.config"
export XDG_CACHE_HOME="/home/kaste/.cache"
export XDG_DATA_HOME="/home/kaste/.local/share"
export XDG_STATE_HOME="/home/kaste/.local/state"

export STEAM_HOME="/home/kaste/.config/steam"
export GNUPGHOME="/home/kaste/.config/gnupg"
