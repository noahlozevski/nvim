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

}
