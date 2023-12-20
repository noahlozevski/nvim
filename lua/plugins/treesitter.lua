return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
        'JoosepAlviste/nvim-ts-context-commentstring',
        'RRethy/nvim-treesitter-textsubjects'
    },
    config = function () 
        require('nvim-treesitter.configs').setup {

            -- A list of parser names, or "all" (the five listed parsers should always be installed)
            ensure_installed = {
                'cpp', 'javascript', 'rust', 'typescript', 'lua'
            },

            -- ensure_installed = "all",
            --
            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,

            -- List of parsers to ignore installing (for "all")
            ignore_install = {},

            ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
            -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

            highlight = {
                enable = true,
                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },

            -- incremental selection, is this better than the text object one????
            incremental_selection = {
                enable = true,
                keymaps = {
                    -- init_selection = '<CR>',
                    -- scope_incremental = '<CR>',
                    -- node_incremental = '<TAB>',
                    -- node_decremental = '<S-TAB>',

                    unit_selection = 'gnn',
                    node_incremental = 'grn',
                    scope_incremental = 'grc',
                    node_decremental = 'grm',
                },
            },

            -- -- uses comment string from language grammar
            -- context_commentstring = {
            --     enable = true,
            --     enable_autocmd = false
            -- },
            --

            -- smart incremental selection
            textsubjects = {
                enable = true,
                prev_selection = ',', -- (Optional) keymap to select the previous selection
                keymaps = {
                    ['.'] = 'textsubjects-smart',
                    [';'] = 'textsubjects-container-outer',
                    ['i;'] = 'textsubjects-container-inner',
                },
            },
        }
    end
}
