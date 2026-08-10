#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")"

cp ~/.bashrc    /home/cadenas/.arch/
cp ~/.dircolors /home/cadenas/.arch/
cp ~/.xinitrc   /home/cadenas/.arch/

bash export-packages.sh # A
bash export-nvim.sh     # B
bash export-pipewire.sh # C
bash export-dunst.sh    # D
bash export-torblock.sh # E
bash export-arch.sh     # 01
bash export-obs.sh      # 02
