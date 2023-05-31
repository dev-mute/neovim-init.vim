local status, nvim_treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not status then
    return
end

local config = {
    -- A list of parser names, or "all"
    -- 	Required: c, lua, vim, vimdoc, query
    -- 	Required for lspsaga: markdown, markdown_inline
    ensure_installed = {
        "c",               -- required
        "lua",             -- required
        "vim",             -- required
        "vimdoc",          -- required
        "query",           -- required
        "markdown",        -- required LSPSaga
        "markdown_inline", -- required LSPSaga
        "python",
        "javascript",
        "typescript",
        "html",
        "css",
    },

    indent = {
        enable = true,
        disable = { "python", },
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}

nvim_treesitter_configs.setup(config)
