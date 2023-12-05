function PatchHighlightGroup(group, tbl)
    local hl_old = vim.api.nvim_get_hl(0, { name = group })
    local hl_new = vim.tbl_extend('force', hl_old, tbl)
    vim.api.nvim_set_hl(0, group, hl_new)
end

function ColorSchemeFix(color)
    color = color or "github_dark_high_contrast"
    -- color = color or "github_dark"
    vim.cmd.colorscheme(color)

    -- Update the colorscheme for personal preference
    PatchHighlightGroup("Function", { bold = true })
    PatchHighlightGroup("DiagnosticUnnecessary", { link = "DiagnosticUnderlineError" })

    -- LSP Signature active parameter
    PatchHighlightGroup("LspSignatureActiveParameter", { link = "Substitute" })
end

function ColorSchemeFixTransparency()
    -- Remember to set a terminal background/terminal transparency to desktop
    PatchHighlightGroup("Normal", { bg = "none" })
    PatchHighlightGroup("NormalNC", { link = "Normal" })
    PatchHighlightGroup("NormalFloat", { link = "Normal" })

    -- Nvimtree recoloring to match transparency
    PatchHighlightGroup("NormalSB", { link = "Normal" })

    -- VertSplit recoloring to match transparency
    PatchHighlightGroup("VertSplit", { link = "lualine_c_inactive" })

    -- CMP pop-over autocomplete suggestions
    PatchHighlightGroup("Pmenu", { bg = "none" })
end

ColorSchemeFix()
ColorSchemeFixTransparency()

function ShowRootHighlightUnderCursor()
    local function FindRoot(id, tree)
        local transId = vim.fn.synIDtrans(id)
        local name = vim.fn.synIDattr(id, 'name')
        table.insert(tree, name)

        if id == transId then
            print(table.concat(tree, ' -> '))
        else
            FindRoot(transId, tree)
        end
    end
    local id = vim.fn.synID(vim.fn.line("."), vim.fn.col("."), 0)
    FindRoot(id, {})
end
