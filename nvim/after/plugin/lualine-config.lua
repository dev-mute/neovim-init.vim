local status, lualine = pcall(require, "lualine")
if not status then
    return
end

local function relative_filepath()
    return "%{expand('%:~:.')}"
end

local config = {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {relative_filepath},
        lualine_x = {'encoding', 'fileformat'},
        lualine_y = {'filetype'},
        lualine_z = {'location', 'progress'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {relative_filepath},
        lualine_x = {'encoding', 'fileformat', 'filetype', 'location', 'progress'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {
        lualine_a = {{
            'tabs', mode=1, use_mode_colors=true,
            fmt = function(name, context)
                -- Show + if buffer is modified in tab
                local buflist = vim.fn.tabpagebuflist(context.tabnr)
                local winnr = vim.fn.tabpagewinnr(context.tabnr)
                local bufnr = buflist[winnr]
                local mod = vim.fn.getbufvar(bufnr, '&mod')

                return name .. (mod == 1 and ' +' or '')
            end
        }},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    extensions = {"quickfix", "fugitive", "nvim-tree"}
}

lualine.setup(config)
