local status, signature = pcall(require, "lsp_signature")
if not status then
    return
end

-- TODO: still some issues near the window borders
local function NvimCmpYOffFix()
    local cmp_status, cmp = pcall(require, "cmp")
    if not cmp_status then
        -- Top half of the buffer: (cur_line - 1 < cur_buf_height / 2)
        if vim.fn.winline() - 1 < vim.fn.winheight(0) / 2 then
            return 0 -- display above (with floating_window_above_cur_line = true)
        end
        -- Bottom half of the buffer
        return 4 -- display below
    end
    -- Don't check cmp.visible(), difference between ex: require(| and require("|
    if cmp.core.view.custom_entries_view:is_direction_top_down() then
        return 0
    else
        return 4
    end
end

local config = {
    bind = true,
    doc_lines = 0, -- Only show the function name and parameters
    handler_opts = {
        border = "single",
    },

    -- Floating Window
    floating_window_above_cur_line = true,
    floating_window_off_x = -1,
    floating_window_off_y = NvimCmpYOffFix,

    -- Hint Config
    hint_enable = false, -- Disable the parameter hinting
}

signature.setup(config)
