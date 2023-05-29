local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

local plugin_reload_augroup = vim.api.nvim_create_augroup("PluginSetupReload", { clear = true })
vim.api.nvim_create_autocmd({
        "BufWritePost"
    },
    {
        pattern = "plugins-setup.lua",
        callback = function()
            vim.cmd.source("<afile>")
            vim.cmd.PackerSync()
        end,
        group = plugin_reload_augroup,
    }
)

return require("packer").startup(function(use)
    -- Plugin Manager --
    use { "wbthomason/packer.nvim" }

    -- Fuzzy finder
    use { "nvim-telescope/telescope.nvim", tag = "0.1.1", requires = { "nvim-lua/plenary.nvim" } }

    -- File Tree
    use { "nvim-tree/nvim-tree.lua", requires = { "nvim-tree/nvim-web-devicons" } }

    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

    -- Improved Undo
    use { "mbbill/undotree" }

    -- Session Management
    use { "rmagatti/auto-session" }

    -- Git Integration
    use { "tpope/vim-fugitive" }

    -- LSP --
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }

    use { "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required
            -- Mason LSP manager
            {
                "williamboman/mason.nvim", -- Optional
                run = function()
                    ---@diagnostic disable-next-line: param-type-mismatch
                    pcall(vim.cmd, "MasonUpdate")
                end,
            },
            { "williamboman/mason-lspconfig.nvim" }, -- Optional
            -- Autocompletion
            { "hrsh7th/nvim-cmp" },                  -- Required
            { "hrsh7th/cmp-buffer" },                -- Optional buffer sources
            { "hrsh7th/cmp-path" },                  -- Optional path sources
            { "hrsh7th/cmp-nvim-lsp" },              -- Required
            { "L3MON4D3/LuaSnip" },                  -- Required
            { "saadparwaiz1/cmp_luasnip" },          -- Optional
            { "rafamadriz/friendly-snippets" },      -- Optional default snippets
            { "onsails/lspkind.nvim" },              -- Optional completion formatting
        }
    }

    -- LSP pop-over UI windows
    use { "glepnir/lspsaga.nvim",
        branch = "main",
        requires = {
            { "nvim-tree/nvim-web-devicons" },
            { "nvim-treesitter/nvim-treesitter" }
        }
    }

    use { "ray-x/lsp_signature.nvim" }

    -- Automatically generate matching container characters: (), [], etc.
    use { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup {} end }

    use { "tpope/vim-surround" }

    -- Colorscheme
    use { "projekt0n/github-nvim-theme" }

    -- Indentation visualization
    use { "lukas-reineke/indent-blankline.nvim" }

    -- Statusline
    use { "nvim-lualine/lualine.nvim", requires = { "nvim-tree/nvim-web-devicons" } }

    -- Splashscreen startup menu
    use { "goolord/alpha-nvim", requires = { "nvim-tree/nvim-web-devicons" }, }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)
