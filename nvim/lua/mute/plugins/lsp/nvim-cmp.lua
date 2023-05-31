local cmp_status, cmp = pcall(require, 'cmp')
if not cmp_status then
    return
end

local lspkind_status, lspkind = pcall(require, 'lspkind')
if not lspkind_status then
    return
end

local cmp_action = require('lsp-zero').cmp_action()

require("luasnip.loaders.from_vscode").lazy_load()

local config = {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({ select = true }),

        -- Navigate the suggestions with C-hjkl
        -- C-jk always scroll the suggestions in the same selection_order
        -- j goes down, k goes up
        ['<C-j>'] = function(fallback)
            if cmp.visible() then
                if cmp.core.view.custom_entries_view:is_direction_top_down() then
                    cmp.select_next_item()
                else
                    cmp.select_prev_item()
                end
            else
                fallback()
            end
        end,
        ['<C-k>'] = function(fallback)
            if cmp.visible() then
                if cmp.core.view.custom_entries_view:is_direction_top_down() then
                    cmp.select_prev_item()
                else
                    cmp.select_next_item()
                end
            else
                fallback()
            end
        end,
        ['<C-h>'] = cmp.mapping.scroll_docs(4),
        ['<C-l>'] = cmp.mapping.scroll_docs(-4),

        -- Supertab mappings
        ["<Tab>"] = cmp_action.luasnip_supertab(),
        ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp', group_index = 1 }, -- suggestions from LSP
        { name = 'luasnip',  group_index = 1 }, -- suggestions from snip
        { name = 'buffer',   group_index = 2 }, -- suggestions from current buffer
        { name = 'path',     group_index = 2 }, -- suggestions from filepath
    }),
    formatting = {
        fields = { 'abbr', 'menu', 'kind' },
        format = lspkind.cmp_format({
            mode = 'symbol', -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
            maxwidth = 50,   -- prevent the popup from showing more 50 characters
            ellipsis_char = '...',

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization.
            -- (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, item)
                local menu_icon = {
                    nvim_lsp = 'λ',
                    luasnip = '⋗',
                    buffer = 'Ω',
                    path = '🖫',
                    nvim_lua = 'Π',
                }
                item.menu = menu_icon[entry.source.name]
                return item
            end,
        }),
    },
    view = {
        entries = { name = 'custom', selection_order = 'near_cursor' },
    },
    completion = {
        completeopt = 'menu,menuone,noinsert', -- default select the first copmletion option
    },
    window = {
        documentation = {
            border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
        },
        completion = {
            border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
        }
    },
    experimental = {
        ghost_text = true,
    }
}

cmp.setup(config)
