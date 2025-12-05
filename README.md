# arch-hud

arch-hud is a personal build of [suckless](https://suckless.org/) tools for daily use on Arch Linux.

Built around the concept of a *heads-up display*, trying to make the computer feel like a tool again and not a cognitive black hole.
Implements a few minimal patches (listed below) with a low tech feel based around an 8bit palette and pixel fonts.

No gaps, no transparency, no compositor, **no distractions**. Do add [picom](https://github.com/yshui/picom) if you experience screen tearing.

## installed software and patches

To install just go into each directory and sudo make clean install (script pending).

- [dunst](https://github.com/dunst-project/dunst) - simple notification daemon

### [dwm](https://dwm.suckless.org/) - tiling windows manager
- [main monitor only statusbar](https://dwm.suckless.org/patches/mainmon/)
- [tag to other monitors](https://dwm.suckless.org/patches/tagothermonitor/)
- [hide unused tabs](https://dwm.suckless.org/patches/hide_vacant_tags/)
- [executable name in tag](https://dwm.suckless.org/patches/taglabels/)
- [signal statusbar location and button](https://dwm.suckless.org/patches/statuscmd/)
- [add vertical resizing](https://dwm.suckless.org/patches/stackmfact/)

### [dmenu](https://tools.suckless.org/dmenu/) - dynamic menu
- [highlight searched chars](https://tools.suckless.org/dmenu/patches/highlight/)
- [sort by popularity cache](https://tools.suckless.org/dmenu/patches/sort_by_popularity/)

### [st](https://st.suckless.org/) - simple terminal emulator
- [scrollback & scrollback mouse](https://st.suckless.org/patches/scrollback/)
- [drag and drop filepaths and urls](https://st.suckless.org/patches/drag-n-drop/)
- [specify opening working dir](https://st.suckless.org/patches/workingdir/)
- [open a new terminal in current working directory](https://st.suckless.org/patches/newterm/)

### [surf](https://surf.suckless.org/) - minimal browser
- [homepage](https://surf.suckless.org/patches/homepage/)
- [short title for tabs](https://surf.suckless.org/patches/short-title/)
- [websearch keymap](https://surf.suckless.org/patches/web-search/)

### [tabbed](https://tools.suckless.org/tabbed/) - tab builder
- [drag tabs left or right](https://tools.suckless.org/tabbed/patches/drag/)
- [clamp large tab numbers](https://tools.suckless.org/tabbed/patches/move-clamped/)
- [open new terminal tabs on current working directory](https://tools.suckless.org/tabbed/patches/cwd/)

### dwmblocks
- username
- date
- status
- disk space
- mpv (currently playing)
