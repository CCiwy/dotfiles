return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use({
        "L3MON4D3/LuaSnip",
        -- follow latest release.
    })
    -- fuzzy finder --
    use {'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim' }}
    }

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        },
    }
    -- status line -- 
    use {'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    -- git sti --

    use('tpope/vim-fugitive')

    -- undotree --
    use('mbbill/undotree')
    -- treesitter --
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }
    use('nvim-treesitter/nvim-treesitter-context')

    use({"HiPhish/rainbow-delimiters.nvim",})


    -- lsp core --
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    -- completion --
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    -- git blame
    use {'f-person/git-blame.nvim'}

    -- typescript
    use {
        "pmizio/typescript-tools.nvim",
        requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        config = function()
            require("typescript-tools").setup({})
        end,
    }
    -- cucumber
    use {"tpope/vim-cucumber",
        ft = { "cucumber", "feature" }
    }

    -- dark theme --
    use {"olimorris/onedarkpro.nvim"}

    -- render markdown
    use({
        'MeanderingProgrammer/render-markdown.nvim',
        after = { 'nvim-treesitter' },
        -- requires = { 'echasnovski/mini.nvim', opt = true }, -- if you use the mini.nvim suite
        -- requires = { 'echasnovski/mini.icons', opt = true }, -- if you use standalone mini plugins
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }, -- if you prefer nvim-web-devicons
        config = function()
            require('render-markdown').setup({})
        end,
    })
    use {'MunifTanjim/eslint.nvim'}

    use {'thePrimeagen/99'}
end)

