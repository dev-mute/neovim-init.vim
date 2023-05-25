local status, auto_session = pcall(require, "auto-session")
if not status then
    return
end

local function remove_fugitive_tab()
    local tabpages = vim.api.nvim_list_tabpages()
    for _, tabpage in ipairs(tabpages) do
        local windows = vim.api.nvim_tabpage_list_wins(tabpage)
        for _, window in ipairs(windows) do
            local buffer = vim.api.nvim_win_get_buf(window)
            local file_name = vim.api.nvim_buf_get_name(buffer)
            if string.find(file_name, "fugitive:") then
                vim.api.nvim_win_close(window, true)
                break
            end
        end
    end
end

local config = {
    log_level = "info",
    auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
    auto_restore_enabled = false,
    auto_session_use_git_branch = true,
    bypass_session_save_file_types = { "alpha" },
    pre_save_cmds = {
        --remove_fugitive_tab,
    },
    session_lens = {
        -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
        load_on_setup = true,
        theme_conf = { border = true },
        previewer = true,
    },
}

auto_session.setup(config)

-- Telescope integration
require("telescope").load_extension("session-lens")
