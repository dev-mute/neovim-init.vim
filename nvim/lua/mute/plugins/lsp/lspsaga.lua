local status, lspsaga = pcall(require, "lspsaga")
if not status then
    return
end


local config = {
    preview = {
        lines_above = 0,
        lines_below = 10,
    },
    scroll_preview = {
        scroll_down = "<C-j>",
        scroll_up = "<C-k>",
    },
    request_timeout = 2000,
    ui = {
        -- This option only works in Neovim 0.9
        title = true,
        -- Border type can be single, double, rounded, solid, shadow.
        border = "single",
        winblend = 0,
        expand = "",
        collapse = "",
        --code_action = "💡",
        code_action = " ",
        incoming = " ",
        outgoing = " ",
        hover = ' ',
        kind = {},
    },
    finder = {
        max_height = 0.5,
        min_width = 30,
        force_max_height = false,
        keys = {
            jump_to = 'i',
            expand_or_jump = 'o',
            vsplit = 'v',
            split = 'x',
            tabe = 't',
            tabnew = 'r',
            quit = { 'q', '<ESC>' },
            close_in_preview = '<ESC>',
        },
    },
    code_action = {
        num_shortcut = true,
        extend_gitsigns = true,
        keys = {
            -- string | table type
            quit = { "q", "<ESC>" },
            exec = "<CR>",
        },
    },
    lightbulb = {
        enable = false,
    },
    rename = {
        quit = "<ESC>",
        exec = "<CR>",
        mark = "x",
        confirm = "<CR>",
        in_select = true,
    },
    symbol_in_winbar = {
        enable = false,
        ignore_patterns = { "^.*$" },
    },
}

lspsaga.setup(config)
