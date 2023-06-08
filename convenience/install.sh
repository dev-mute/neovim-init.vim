#!/bin/bash -e

# "Convenience" Install Script for Optixal's neovim-init.vim

# Installs neovim and all necessary dependencies.
# Does not check if dependencies have already been installed.
# Highly recommended to go through each command and run them manually instead of using this convenience script, especially if you are running macOS/WSL/other Linux distros.
# For macOS, use homebrew instead of apt.

# Vars used when downloading and installing neovim and dependencies
NEOVIM_VERSION=0.9.0

# Check if this script is being run in the "convenience" directory
if ! [[ "$PWD" = */convenience ]]; then
    echo '[-] Please run the installation script within the "convenience" directory: cd convenience && ./install.sh'
    exit 1
fi

# Check if existing nvim config is present
if [ -f ~/.config/nvim/init.vim ] || [ -f ~/.config/nvim/init.lua ]; then
    echo '[-] Existing nvim init config file found in ~/.config/nvim/. Please backup or remove it first before running this script.'
    exit 1
fi

# Make config directory for Neovim's init.vim
echo '[*] Preparing Neovim config directory ...'
mkdir -p ~/.config/nvim

echo '[*] Installing dependencies ...'
# Installs the following dependencies:
#  * wget (for downloading neovim package)
#  * git (for packer)
#  * build-essential (or gcc for mac) (for nvim-treesitter's TSInstall and telescope-fzf-native's initial make)
#  * ripgrep (for telescope)
#  * python3 (and python3-pip and python3-venv for linux) (for Python 3 capabilities, e.g. pynvim and doq python docstrings)
#  * luarocks (for configuration files)
if [[ "$OSTYPE" = "darwin"* ]]; then
    brew install \
        wget \
        curl \
        git \
        gcc \
        ripgrep \
        python3 \
        luarocks
else
    sudo apt update
    sudo apt install \
        wget \
        curl \
        git \
        build-essential \
        ripgrep \
        python3 \
        python3-pip \
        python3-venv \
        luarocks\
        -y
fi

mkdir -p ~/.local/bin

# Add ~/.local/bin to PATH if it's not already in it
if ! [[ ":$PATH:" == *":$HOME/.local/bin:"* ]]; then
    echo "[*] Adding ~/.local/bin to PATH"
    if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
        SHELL_CONFIG_FILE=~/.zshrc
    elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
        SHELL_CONFIG_FILE=~/.profile
    else
        echo "[-] Could not detect what shell you are using. Ensure to manually add ~/.local/bin to your PATH"
    fi
    echo -e '\nPATH="$HOME/.local/bin:$PATH"' >> $SHELL_CONFIG_FILE
    export PATH="$HOME/.local/bin:$PATH"
fi

# Install neovim
echo "[*] Installing neovim $NEOVIM_VERSION ..."
if [[ ! $(nvim --version 2>&1 | head -n 1) == "NVIM v$NEOVIM_VERSION" ]]; then
    wget "https://github.com/neovim/neovim/releases/download/v$NEOVIM_VERSION/nvim-linux64.tar.gz" -O /tmp/nvim-linux64.tar.gz
    tar xf /tmp/nvim-linux64.tar.gz -C ~/.local
    ln -sf $(readlink -f ~/.local/nvim-linux64/bin/nvim) ~/.local/bin/nvim
else
    echo "[-] NVIM v$NEOVIM_VERSION already installed, skipping"
fi


# Install virtualenv to containerize dependencies for vim-pydocstring (doq) and formatting feature (pynvim for black plugin)
echo "[*] Installing Python dependencies in a virtual environment ..."
python3 -m venv ~/.config/nvim/venv
source ~/.config/nvim/venv/bin/activate
pip install wheel
pip install pynvim doq
deactivate

# Install packer plugin manager
echo "[*] Installing packer ..."
if [[ ! -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]]; then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
else
    echo "[-] Packer already installed, skipping"
fi

# Enter Neovim and install plugins with packer's :PackerInstall using a temporary init.lua (to avoid warnings from uninstalled packages
echo "[*] Running :PackerInstall within nvim ..."
sed '/end)/q' ../nvim/lua/mute/plugins-setup.lua > ~/.config/nvim/init.lua
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# Copy init.lua from this installer into nvim's config location
echo "[*] Copying nvim configuration -> ~/.config/nvim ..."
cp -r ../nvim/* ~/.config/nvim/

echo -e "[+] Done, welcome to your new \033[1m\033[92mneovim\033[0m experience! Try it by running nvim"
