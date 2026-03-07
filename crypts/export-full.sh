#!/usr/bin/env bash

cp ~/.bashrc    ~/.arch/
cp ~/.dircolors ~/.arch/
cp ~/.xinitrc   ~/.arch/

bash export-packages.sh # A
bash export-nvim.sh     # B
bash export-pipewire.sh # C
bash export-dunst.sh    # D
bash export-rmpc.sh     # E

bash export-arch.sh     # 01
bash export-obs.sh      # 02
bash export-gimp.sh     # 03
