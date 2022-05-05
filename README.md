# Optixal's Neovim init.vim

Just like how a 🔪 is undoubtedly the most important tool of a sushi chef, a text editor is undoubtedly the most important tool of a developer. It has to be robust, versatile, extensible, performant and powerful. It requires sharpening every now and then in order to produce quality work that you are proud of. Lastly, it has to look and feel good in hand so that every use will feel enjoyable.

![Neovim-New](https://user-images.githubusercontent.com/19287477/166893010-43bbbf6e-f59b-44a3-b841-359f21d464d6.gif)

TODO: Plugins, wallpaper, font, etc.

## Installing and Updating

### Automated Installation

```sh
cd convenience
./install.sh
```

Automatically installs my configuration along with dependencies into your system. Tested on Ubuntu 22.04. I highly suggest reading and understanding each line of the installation script before running it, especially if you are using other Linux distros, or macOS. For macOS, manually run the commands, and use `homebrew` instead of `apt`.

### Manual Installation

TODO

### Post Installation

#### Download and install a Nerd Font

nvim-cmp, telescope, lualine and nvim-tree require a patched font to display icons properly. [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) are recommended. Run `./font_install.sh` to download and install Iosevka Term Nerd Font into your `~/.fonts` directory, or run the command manually:

```sh
curl -fLo ~/.fonts/Iosevka\ Term\ Nerd\ Font\ Complete.ttf --create-dirs https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Iosevka/Regular/complete/Iosevka%20Term%20Nerd%20Font%20Complete.ttf
fc-cache -rv
```

Once downloaded, open your terminal's preferences and change the font to "Iosevka Term Regular". If the font is not there, your OS' font directory may not be `~/.fonts`. Find out which directory your fonts are stored in, and place the downloaded font file in that directory instead.

If you are using a GPU-accelerated terminal like kitty, it is better to [avoid using a Nerd Font and use the original font instead](https://sw.kovidgoyal.net/kitty/faq/?highlight=nerd#kitty-is-not-able-to-use-my-favorite-font). Only download and install `NerdFontsSymbolsOnly.zip` from [Nerd Font's releases page](https://github.com/ryanoasis/nerd-fonts/releases) and the terminal should pick up the symbols automatically as the fallback font. Note, if the symbols' sizes are off, you can avoid `NerdFontsSymbolsOnly.zip` and just use the Nerd Font (e.g. the one downloaded in the `curl` example above) as the fallback font, while still benefiting from the cached original fonts.

#### Install language servers

As I focus on Python development, the installation script installs Python language server (pyright) by default. To install additional language servers (e.g. TypeScript):

```sh
npm install -g typescript-language-server
```

Then add it to list of servers in the lua section of init.vim:

```lua
local servers = {
    'pyright',
    'tsserver',
}
```

For other language servers, refer to [this list](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md) to see the packages you need to install.

#### Alias vim

It may be easier for you to type `vim` instead of `nvim` everytime you edit a file, so aliasing it could save you some trouble. Add an alias to your bashrc/zshrc/somerc or aliases file to alias nvim to vim:

```sh
echo "alias vim='nvim'" >> ~/.zshrc
```

#### Fix nvim + tmux issues

Running nvim within a tmux session may cause certain unwanted issues like escape key lag, or displaying wrong colors. Run `cat .tmux.conf >> ~/.tmux.conf` or manually add these to your `~/.tmux.conf` configuration file to address the issues:

```sh
set -sg escape-time 5 # fix vim esc delay
set -g default-terminal "screen-256color" # ensures vim uses right $TERM color, default is "screen"
set -ga terminal-overrides ",*256col*:Tc" # fixes vim reproducing slightly wrong colors in tmux
```

#### Install and update plugins

Run these to install new plugins, update or delete existing plugins, or upgrade vim-plug itself.

* Install plugins: `:PlugInstall` in nvim. Run this after adding new plugins (e.g. `Plug 'username/repo'`) to init.vim
* Update plugins: `:PlugUpdate` in nvim
* Delete unused plugins: `:PlugClean` in nvim
* Update vim-plug itself: `:PlugUpgrade` in nvim

## Custom Mapped Commands in Normal Mode

Core:
* `,` - Map leader, nearly all my custom mappings starts with pressing the comma key
* `,q` or `\\` - Toggle sidebar filetree viewer (nvim-tree.lua)
* `,r` - Refresh/source ~/.config/nvim/init.vim
* `,t` - Trim all trailing whitespaces
* `,a` - Auto align variables (vim-easy-align), eg. do `,a=` while your cursor is on a bunch of variables to align their equal signs
* `,h` - Toggle rainbow parentheses highlighting (rainbow-parentheses.vim)
* `,j` - Set filetype to "journal" which makes the syntax highlighting beautiful when working on regular text files and markdown
* `,k` - Toggle coloring of hex colors
* `,l` - Toggle Limelight mode, highlight the lines near cursor only (Limelight)
* `,,` - Remove highlights (after searching with `/`)
* `<Tab>` - Next buffer
* `<Shift-Tab>` - Previous buffer
* `,$s` - New terminal in horizontal split
* `,$v` - New terminal in vertical split

Python:
* `,d` - Automatically generate Python docstrings while cursor is hovering above a Python function or class (vim-pydocstring and doq)
* `,x` - Auto format Python scripts (yapf)

Telescope:
* `,ff` - Find files
* `,fg` - Live grep from files
* `,fb` - Buffers
* `,fh` - Help tags
* `,fc` - Change colorscheme
* `,f/` - Fuzzy find current buffer

Other mappings:
* `,c<Space>` - Toggle comment for current line (Nerd Commenter)
* `<Alt-r/c>` - Toggle RGB color picker (vCoolor) (uses GTK+, requires yad or zenity)
* [nvim-lspconfig mappings](https://github.com/neovim/nvim-lspconfig#suggested-configuration)

