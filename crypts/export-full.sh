#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")"

cp ~/.bashrc    /home/cadenas/.arch/
cp ~/.dircolors /home/cadenas/.arch/
cp ~/.xinitrc   /home/cadenas/.arch/

bash export-b-nvim.sh     # B
bash export-c-pipewire.sh # C
bash export-d-dunst.sh    # D
bash export-f-arch.sh     # 01
bash export-g-obs.sh      # 02
bash export-h-havitat.sh  # 03
