vim.g.mapleader = ";"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.guicursor = ""
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4

vim.opt.syntax = "on"
vim.opt.filetype = "on"
vim.opt.cursorline = true

vim.wo.wrap = false
vim.wo.linebreak = true

vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.copyindent = true
-- vim.opt.smartindent = true

-- Fix python-specific indentation
-- https://neovim.io/doc/user/indent.html#ft-python-indent
vim.g.python_indent = {
    disable_parentheses_indenting = false,
    closed_paren_align_last_line = false,
    searchpair_timeout = 150,
    continue = 'shiftwidth()',
    open_paren = 'shiftwidth()',
    nested_paren = 'shiftwidth()',
}

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.opt.hlsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.showmatch = true

vim.opt.wildmenu = true

vim.opt.showtabline = 2
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.g.python3_host_prog = "~/.config/nvim/venv/bin/python"
