local lsp = require("lsp-zero").preset({})

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
    return
end

lsp.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ["lua_ls"] = { "lua" },
        ["pylsp"] = { "python" },
    },
})

-- (Optional) Configure lua language server for neovim
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

lspconfig.pylsp.setup({
    settings = {
        pylsp = {
            configurationSources = { "pycodestyle" }, -- "pycodestyle" or "flake8"
            plugins = {
                pycodestyle = {
                    maxLineLength = 100,
                    hangClosing = false,
                },
                autopep8 = {
                    enabled = true,
                }
            },
        },
    },
})

lsp.setup()
