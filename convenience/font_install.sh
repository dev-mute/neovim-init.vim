#!/bin/bash

# (Optional but recommended) Install a nerd font for icons and a beautiful airline bar (https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts)
mkdir -p ~/.local/share/fonts

echo "[*] Downloading Hack font into ~/.local/share/fonts ..."
cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Hack/Regular/HackNerdFontMono-Regular.ttf
cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Hack/Bold/HackNerdFontMono-Bold.ttf
cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Hack/Italic/HackNerdFontMono-Italic.ttf
cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Hack/BoldItalic/HackNerdFontMono-BoldItalic.ttf

fc-cache -rv > /dev/null
echo "[+] Downloaded and refreshed cache. Restart your terminal if the font is not appearing in the list of selectable fonts."
