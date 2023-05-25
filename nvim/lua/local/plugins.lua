local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
    -- Plugin Manager --
    use {"wbthomason/packer.nvim"}

    -- Fuzzy finder
    use {"nvim-telescope/telescope.nvim", tag = "0.1.1", requires = {"nvim-lua/plenary.nvim"}}

    -- File Tree
    use {"nvim-tree/nvim-tree.lua",
        requires = {
            "nvim-tree/nvim-web-devicons", -- optional
        },
    }

    -- Improved Undo
    use {"mbbill/undotree"}

    -- Session Management
    use {"rmagatti/auto-session"}

    -- Git Integration
    use {"tpope/vim-fugitive"}

    -- LSP --
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}

    use {"VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        requires = {
            -- LSP Support
            {"neovim/nvim-lspconfig"},             -- Required
            {
                "williamboman/mason.nvim",     -- Optional
                run = function()
                    ---@diagnostic disable-next-line: param-type-mismatch
                    pcall(vim.cmd, "MasonUpdate")
                end,
            },
            {"williamboman/mason-lspconfig.nvim"}, -- Optional

            -- Autocompletion
            {"hrsh7th/nvim-cmp"},     -- Required
            {"hrsh7th/cmp-nvim-lsp"}, -- Required
            {"L3MON4D3/LuaSnip"},     -- Required
        }
    }

    -- LSP pop-over UI windows
    use {"glepnir/lspsaga.nvim",
        branch = "main",
        requires = {
            {"nvim-tree/nvim-web-devicons"},
            {"nvim-treesitter/nvim-treesitter"}
        }
    }

    -- Indentation visualization
    use {"lukas-reineke/indent-blankline.nvim"}

    -- Automatically generate matching container characters: (), [], etc.
    use {"windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup {} end}

    -- Colorscheme
    use {"projekt0n/github-nvim-theme"}

    -- Statusline
    use {"nvim-lualine/lualine.nvim", requires = { "nvim-tree/nvim-web-devicons" }}

    -- Splashscreen startup menu
    use {"goolord/alpha-nvim", requires = {"nvim-tree/nvim-web-devicons"}, }


    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)
