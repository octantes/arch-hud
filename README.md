# arch-hud
this is my build of the suckless tools I use on a daily basis as my arch environment
my goal is to create a heads up display, to make my computer feel like a tool again
minimally patched, using win as the modkey (replaces alt) to prevent most conflicts
also I'm using a very reduced palette and pixel font to add a mostly low-tech feel

I don't use tabbed for terminals, i feel it goes against the minimalist workflow
If you want to launch st with tabs, just uncomment the "tabtermcmd" line in keys
I do use tabbed for the surf browser, as it's mostly unusable for work without it

I don't use gaps or transparency, as it doesn't make sense without a background
I don't use a compositor, but if you experience screentearing I recommend picom

## dwm - tiling windows manager
- main monitor only statusbar: [[mainmon]](https://dwm.suckless.org/patches/mainmon/)
- tag to other monitors: [[tag other monitors]](https://dwm.suckless.org/patches/tagothermonitor/)
- hide unused tabs: [[hide vacant tags]](https://dwm.suckless.org/patches/hide_vacant_tags/)
- executable name in tag: [[taglabels]](https://dwm.suckless.org/patches/taglabels/)
- signal statusbar location and button: [[statuscmd]](https://dwm.suckless.org/patches/statuscmd/)

## dmenu - dynamic menu
- highlight searched chars: [[highlight]](https://tools.suckless.org/dmenu/patches/highlight/)
- sort by popularity cache: [[sort by popularity]](https://tools.suckless.org/dmenu/patches/sort_by_popularity/)

## st - simple terminal emulator
- scrollback & scrollback mouse: [[scrollback]](https://st.suckless.org/patches/scrollback/)
- drag and drop filepaths and urls: [[drag and drop]](https://st.suckless.org/patches/drag-n-drop/)
- specify opening working dir: [[workingdir]](https://st.suckless.org/patches/workingdir/)
- open a new terminal in current working directory: [[newterm]](https://st.suckless.org/patches/newterm/)

## surf - minimal browser NOT CURRENTLY INSTALLED
- homepage: [[homepage]](https://surf.suckless.org/patches/homepage/)
- short title for tabs: [[short title]](https://surf.suckless.org/patches/short-title/)
- websearch keymap: [[web search]](https://surf.suckless.org/patches/web-search/)

# tabbed - tab builder
- drag tabs left or right: [[drag]](https://tools.suckless.org/tabbed/patches/drag/)
- clamp large tab numbers: [[clamped move]](https://tools.suckless.org/tabbed/patches/move-clamped/)
- open new terminal tabs on current working directory: [[cwd]](https://tools.suckless.org/tabbed/patches/cwd/)

## dwmblocks


### recommended installs
- htop
- maim
