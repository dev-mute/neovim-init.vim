local status_null_ls, null_ls = pcall(require, "null-ls")
if not status_null_ls then
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

-- null-ls is source of truth for installed tools
local null_ls_config = {
    debug = true,
    border = "single",
    sources = {
        formatting.black.with({
            extra_args = { "--line-length", 100 },
        }),
        formatting.stylua,
        diagnostics.selene,
    },
}

null_ls.setup(null_ls_config)

local status_mason_null_ls, mason_null_ls = pcall(require, "mason-null-ls")
if not status_mason_null_ls then
    return
end

-- mason_null_ls automatically installs requested tools from null_ls
local mason_null_ls_config = {
    ensure_install = nil, -- set of tools determined by null_ls sources
    automatic_installation = true,
    handlers = {

    },
}

mason_null_ls.setup(mason_null_ls_config)
