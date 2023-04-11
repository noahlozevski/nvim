-- Check if packer exists, if not, then install

if not pcall(vim.cmd, [[packadd packer.nvim]]) then
    if vim.fn.input("Install packer? (y)") ~= "y" then
        return
    end

    local install_dir = string.format(
        '%s/site/pack/packer/opt/',
        vim.fn.stdpath('data')
    )

    vim.fn.mkddir(install_dir, 'p')

    print(vim.fn.system(string.format(
        'git clone --depth 1 %s %s',
        'https://github.com/wbthomason/packer.nvim',
        install_dir .. '/packer.nvim'
    )))
    return
end


vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use { 'wbthomason/packer.nvim', opt = true }

    use {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use 'ThePrimeagen/vim-be-good'

    use({
        "catppuccin/nvim",
        as = "catppuccin"
    })

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use 'nvim-treesitter/playground'

    use 'nvim-lua/plenary.nvim'
    use 'ThePrimeagen/harpoon'
    use 'mbbill/undotree'
    use 'tpope/vim-fugitive'

    -- for comment toggling
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- Completion plugins
    -- Auto inserts parathensis / brackets
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    -- for icons in completion menu
    use 'onsails/lspkind.nvim'

    -- for git
    use({ "petertriho/cmp-git", requires = "nvim-lua/plenary.nvim" })
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- cmp filter 'fuzzy_buffer'
    -- https://github.com/tzachar/cmp-fuzzy-buffer
    use { 'tzachar/cmp-fuzzy-buffer', requires = { 'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim' } }

    -- cmp filter 'fuzzy_path'
    -- https://github.com/tzachar/cmp-fuzzy-path
    use { 'tzachar/cmp-fuzzy-path', requires = { 'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim' } }

    -- tmux
    use { 'andersevenrud/cmp-tmux' }
    -- lsp server plugin hoster i think ????
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },              -- Required
            { 'hrsh7th/cmp-nvim-lsp' },          -- Required
            { 'L3MON4D3/LuaSnip' },              -- Required
            { 'lukas-reineke/lsp-format.nvim' }, -- Required for async format on save
            { 'hrsh7th/vim-vsnip' },             -- required for auto complete snips
            { 'hrsh7th/vim-vsnip-integ' },       -- required for auto compelete snips
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            { 'hrsh7th/cmp-nvim-lsp-signature-help' },
            { 'hrsh7th/cmp-calc' },
            { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
            { 'FelipeLema/cmp-async-path' },
            { 'dmitmel/cmp-cmdline-history' },
            -- https://github.com/lukas-reineke/cmp-rg
            { "lukas-reineke/cmp-rg" }, -- ripgrep source for cmp, completes any text in workspace
            -- Zsh autocompletions
            { "tamago324/cmp-zsh" },
            { "Shougo/deol.nvim" },
            { 'hrsh7th/cmp-emoji' },
            { 'hrsh7th/cmp-nvim-lua' },

        }
    }
    use {
        'David-Kunz/cmp-npm',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }

    -- For auto-fetching lsp servers
    use {
        "williamboman/mason.nvim",
        run = ":MasonUpdate" -- :MasonUpdate updates registry contents
    }
end)
