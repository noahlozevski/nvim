return {
    {
        'dstein64/vim-startuptime',
        cmd = 'StartupTime',
        init = function()
            vim.g.startuptime_tries = 10
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { "tsakirist/telescope-lazy.nvim" },
        }
    },

    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        -- :MarkdownPreview
        -- build = "cd app && yarn install",
        build = ":call mkdp#util#install()",
    },


    'ThePrimeagen/vim-be-good',
    'nvim-lua/plenary.nvim',

    'mfussenegger/nvim-jdtls',

    -- Themes
    { 'rose-pine/neovim',           name = 'rose-pine' },
    { "bluz71/vim-nightfly-colors", name = "nightfly" },
    { "bluz71/vim-moonfly-colors",  name = "moonfly" },
    'folke/tokyonight.nvim',
    'ray-x/aurora',
    'rafamadriz/neon',
    {
        "catppuccin/nvim",
        name = "catppuccin"
    },
    'nyoom-engineering/oxocarbon.nvim',
    {
        'projekt0n/github-nvim-theme',
        lazy = false,
    },
    {
        'rebelot/kanagawa.nvim'
    },
    {
        'airblade/vim-gitgutter',
        dependencies = {
            'tpope/vim-fugitive'
        }
    }
}
