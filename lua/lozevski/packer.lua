local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Lazy needs map leader set before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require('lazy').setup({
    'github/copilot.vim',
    {
        'dstein64/vim-startuptime',
        cmd = 'StartupTime',
        init = function()
            vim.g.startuptime_tries = 10
        end
    },

    {
        "folke/zen-mode.nvim",
        event = "VeryLazy"
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    'kessejones/git-blame-line.nvim',

    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" }
        }
    },

    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { "tsakirist/telescope-lazy.nvim" },
        }
    },
    -- Add fzf support to telescope
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
    },

    -- 'mg979/vim-visual-multi',
    'ThePrimeagen/vim-be-good',
    -- "petertriho/nvim-scrollbar"

    -- Themes
    { 'rose-pine/neovim',           name = 'rose-pine' },
    { "bluz71/vim-nightfly-colors", name = "nightfly" },
    { "bluz71/vim-moonfly-colors",  name = "moonfly" },
    'folke/tokyonight.nvim',
    'ray-x/aurora',
    {
        "catppuccin/nvim",
        name = "catppuccin"
    },
    'nyoom-engineering/oxocarbon.nvim',

    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
        keys = {
            { "\\", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },

        },
        config = function()
            require('lozevski.neo-tree')
        end,
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    },
    'nvim-treesitter/playground',

    'nvim-lua/plenary.nvim',
    'ThePrimeagen/harpoon',
    'mbbill/undotree',
    'tpope/vim-fugitive',

    "lukas-reineke/indent-blankline.nvim",
    --
    --
    --
    -- for comment toggling
    {
        'numToStr/Comment.nvim',
    },
    --
    -- Adds virtual lines with additional height for diagnostics
    { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' },

    -- fzf dep
    -- {
    --     'junegunn/fzf',
    --     build = './install --bin'
    -- },
    -- actual fzf integ
    -- {
    --     'ibhagwan/fzf-lua',
    --     dependencies = { 'nvim-tree/nvim-web-devicons' }
    -- },

    -- LSP / Completion
    {
        'VonHeikemen/lsp-zero.nvim',
        lazy = true,
        branch = 'v2.x',
        config = function()
            require('lsp-zero').preset({})
        end
    },

    {
        'hrsh7th/nvim-cmp',
        -- TODO: figure out issues with the eventing, cant get everything to load right lazily
        -- event = "InsertEnter",
        dependencies = {
            { 'L3MON4D3/LuaSnip' }, -- Required
            -- { 'lukas-reineke/cmp-under-comparator' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            -- { 'hrsh7th/cmp-calc' },
            { 'FelipeLema/cmp-async-path' },
            { 'dmitmel/cmp-cmdline-history' }, -- https://github.com/lukas-reineke/cmp-rg
            { "lukas-reineke/cmp-rg" },        -- ripgrep source for cmp, completes any text in workspace
            { 'hrsh7th/cmp-nvim-lua' },
            { "tamago324/cmp-zsh" },
            { 'hrsh7th/vim-vsnip' },       -- required for auto complete snips
            { 'hrsh7th/vim-vsnip-integ' }, -- required for auto compelete snips
            -- {
            --     'David-Kunz/cmp-npm',
            --     dependencies = { 'nvim-lua/plenary.nvim' }
            -- },
            {
                'tzachar/cmp-fuzzy-buffer',
                dependencies = { 'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim' }
            },
            -- {
            --     'tzachar/cmp-fuzzy-path',
            --     dependencies = { 'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim' }
            -- },
            {
                "petertriho/cmp-git",
                dependencies = "nvim-lua/plenary.nvim"
            },
            -- Auto inserts parathensis / brackets
            {
                "windwp/nvim-autopairs",
            },
            -- Zsh autocompletions
            -- { "Shougo/deol.nvim" },
            -- { 'hrsh7th/cmp-emoji' },
            -- for icons in completion menu
            { 'onsails/lspkind.nvim', }
        },
        config = function()
            require('lozevski.cmp')
        end
    },
    {
        'neovim/nvim-lspconfig',
        cmd = 'LspInfo',
        -- TODO: figure out issues with lazy loading
        -- event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },              -- Required
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional
            {
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'lukas-reineke/lsp-format.nvim' }, -- Required for async format on save
            { 'hrsh7th/cmp-nvim-lsp-signature-help' },
            { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
            { 'neovim/nvim-lspconfig' }, -- Required
        },
        config = function()
            require('lozevski.lsp')
        end
    },
})
