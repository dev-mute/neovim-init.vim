local lsp_status, lsp = pcall(require, "lsp-zero")
if not lsp_status then
    return
end

lsp = lsp.preset({
    float_border = "single",
    name = "recommended"
})

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
        ["null-ls"] = { "python" },
        --["pylsp"] = { "python" },
    },
})

-- (Optional) Configure lua language server for neovim
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

lspconfig.pylsp.setup({
    capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function(client)
        -- Disable formatting, see: ./null-ls.lua
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
    settings = {
        pylsp = {
            configurationSources = { "flake8" }, -- "pycodestyle" or "flake8"
            plugins = {
                flake8 = {
                    enabled = true,
                    exclude = { "__init__.py" },
                    ignore = {
                        "E203",
                        "W503",
                    },
                    maxLineLength = 100,
                    hangClosing = false,
                },
                -- pycodestyle, pyflakes, and mccabe are managed by flake8
                -- if flake8 is enabled, these should be disabled
                pycodestyle = {
                    enabled = false,
                    ignore = {
                        "E203",
                        "W503",
                    },
                    maxLineLength = 100,
                    hangClosing = false,
                },
                pyflakes = {
                    enabled = false,
                },
                mccabe = {
                    enabled = false,
                },

                autopep8 = {
                    enabled = false,
                }
            },
        },
    },
})

lsp.setup()
