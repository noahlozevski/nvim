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

    'ThePrimeagen/vim-be-good',
    'nvim-lua/plenary.nvim',

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
        'projekt0n/github-nvim-theme',
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require('github-theme').setup({
                -- ...
            })

            vim.cmd('colorscheme github_dark')
        end,
    }
}
