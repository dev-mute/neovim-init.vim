vim.opt.list = true


require("ibl").setup({
    indent = {
        char = " ",
    },
    whitespace = {
    },
    scope = {
        char = "▎", -- Set scope char to override indent.char
        enabled = true,
        highlight = { "Function", },
    },
})
