local alpha = require("alpha")
local theta = require("alpha.themes.theta")
local config = theta.config

-- Set header
local header = {
    type = "text",
    val = {
        [[                                                                                       ]],
        [[                                                                                       ]],
        [[                                                                                       ]],
        [[                                                                                       ]],
        [[     ▀████▄   ▀████▀ ▀███▀▀▀███   ▄▄█▀▀██▄ ▀████▀    ▀███▀ ▀████▀ ▀█████▄     ▄███▀    ]],
        [[       ████▄    ██     ██     ▀ ▄██▀    ▀██▄ ▀██     ▄██     ██     █████    ████      ]],
        [[       ██ ███   ██     ██       ██▀      ▀██  ██▄    ██      ██     ██ ██   ▄█ ██      ]],
        [[       ██  ▀██▄ ██     ██▄▄▄█   ██        ██   ██   ███      ██     ██  ██  ██ ██      ]],
        [[       ██  ▀██▄ ██     ██▀▀▀█   ██        ██   ██▄  ██▀      ██     ██  ██  █▀ ██      ]],
        [[       ██   ▀██▄██     ██       ██▄      ▄██   ▀██ ██▀       ██     ██  ██▄█▀  ██      ]],
        [[       ██     ████     ██     ▄  ██▄    ▄██▀     ███         ██     ██  ▀██▀   ██      ]],
        [[     ▄████▄    ███   ▄█████████   ▀▀████▀▀       ███       ▄████▄ ▄████▄ ▀▀  ▄████▄    ]],
        [[                                                                                       ]],
        [[                                                                                       ]],
        [[                                                                                       ]],
        [[                                                                                       ]],
    },
    opts = { position = "center", hl = "Type", },
}

local dashboard = require("alpha.themes.dashboard")
local buttons = {
    type = "group",
    val = {
        { type = "text",    val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
        { type = "padding", val = 1 },
        dashboard.button("r", "󰦛  Restore Session: " .. vim.fn.substitute(vim.fn.getcwd(), os.getenv("HOME"), "~", ""),
            "<cmd>SessionRestore<CR>"),
        dashboard.button("; s s", "󱤇  Search Sessions"),
        { type = "padding", val = 1 },
        dashboard.button("e", "  New File", "<cmd>ene<CR>"),
        dashboard.button("; f f", "?  Find File"),
        dashboard.button("; f s", "  Find Text"),
        { type = "padding", val = 1 },
        dashboard.button("u", "  Update Plugins", "<cmd>PackerSync<CR>"),
        dashboard.button("c", "  Configuration", "<cmd>cd ~/.config/nvim<CR>"),
        dashboard.button("q", "󰅚  Quit", "<cmd>qa<CR>"),
    },
    position = "center",
}

config.layout[2] = header
config.layout[6] = buttons

alpha.setup(config)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
