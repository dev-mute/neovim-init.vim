#!/bin/bash -e

# "Convenience" sync script to update files in this repo with local modifications to ~/.config/nvim

# Check if this script is being run in the "convenience" directory
if ! [[ "$PWD" = */convenience ]]; then
    echo '[-] Please run the installation script within the "convenience" directory: cd convenience && ./sync.sh'
    exit 1
fi

# Check if existing nvim config is present
if [ -f ~/.config/nvim/init.vim ] || [ -f ~/.config/nvim/init.lua ]; then
    echo '[+] Existing nvim init config file found in ~/.config/nvim/.'
fi

echo '[+] Copying ~/.config/nvim/ to ../nvim/.'
mkdir -p ../nvim/
cp -r ~/.config/nvim/* ../nvim/
