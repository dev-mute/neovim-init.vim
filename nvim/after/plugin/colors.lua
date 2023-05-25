function PatchHighlightGroup(group, tbl)
    local hl_old = vim.api.nvim_get_hl_by_name(group, true)
    local hl_new = vim.tbl_extend('force', hl_old, tbl)
    vim.api.nvim_set_hl(0, group, hl_new)
end

function ColorSchemeFix(color)
    color = color or "github_dark_high_contrast"
    -- color = color or "github_dark"
    vim.cmd.colorscheme(color)

    -- Update the colorscheme for personal preference
    PatchHighlightGroup("Function", { bold = true })

    -- IndentBlankline recoloring to match colorscheme
    local hl_comment = vim.api.nvim_get_hl_by_name("Comment", true)
    PatchHighlightGroup("IndentBlanklineContextChar", hl_comment)
    PatchHighlightGroup("IndentBlanklineContextStart", { sp = hl_comment.foreground })

end

function ColorSchemeFixTransparency()
    -- Remember to set a terminal background/terminal transparency to desktop

    PatchHighlightGroup("Normal", { bg = "none" })
    PatchHighlightGroup("NormalNC", { link = "Normal"})
    PatchHighlightGroup("NormalFloat", { link = "Normal" })

    -- Nvimtree recoloring to match transparency
    PatchHighlightGroup("NormalSB", { link = "Normal"})

    -- VertSplit recoloring to match transparency
    PatchHighlightGroup("VertSplit", {link = "lualine_c_inactive"})
end

ColorSchemeFix()
ColorSchemeFixTransparency()
