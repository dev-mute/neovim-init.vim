local status, telescope = pcall(require, "telescope")
if not status then
    return
end

local actions = require('telescope.actions')
local config = {
    defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        file_ignore_patterns = { "^env/", "^venv/", "%.pyc" },
        mappings = {
            i = {
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
            n = { ["q"] = actions.close },
        },
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
    },
    extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
    }
}

telescope.setup(config)
