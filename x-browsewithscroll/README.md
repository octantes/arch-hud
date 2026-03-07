# browsewithscroll

**scroll** is a local tool for previewing and organizing your font and media collections directly in your browser.  
No internet connection or installation required — simply run the launcher script and it will index your folders.

Built for designers and creators who need a lightweight way to browse local assets without heavy software. Ideal for those who prefer simplicity, privacy, and control. Not for complex asset management, but handles large directories.

All your data stays on your machine. The tool works by "baking" your file lists into static pages, working around CORS for local file access without running a server. Remember to `chmod +x launch.sh`!

![preview](preview.gif)

## Features

**scroll** is stable and functional, aimed at staying minimal: just drop your files in the folders, run the script, and start browsing.

* **Zero-Dependency**: No need to install external libraries, the scripts use only standard Unix tools.
* **Font Files**: Preview `.ttf`, `.otf`, and `.woff` files with live rendering and a lorem ipsum fragment.
* **Media Files**: Support for common images (`jpg`, `png`, `webp`, `gif`) and videos (`mp4`, `webm`, `ogg`).
* **Launch & Sync**: A single `launch.sh` script updates your asset lists and opens the browser or a new tab.
* **Shuffle Mode**: Explore your collection in random order, or disable the shuffle toggle for sequential order.
* **Serverless approach**: Works directly via the `file://` protocol; no local server or node environment required.
* **Hiper-light**: Minimal overhead, keeping the interface snappy even with thousands of assets.

**WIP**: Grid view mode > Custom text input > Basic file metadata display > Tagging system

Remember that **new files won't show up until you run the launcher!** — run it whenever you update your folders.

Pro tip: *save index.html as bookmark for easy access after the first launch!*

---
<p align="center">
  <strong><em>designed with simplicity in mind, to keep you in control</em></strong>
  <br><br>
  <img src="assets/scroll.svg" width="120"/>
</p>
