return {
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
                -- load custom cmp config
                require('lozevski.cmp')
            end
        }
