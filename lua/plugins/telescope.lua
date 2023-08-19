return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { "tsakirist/telescope-lazy.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim" },
        { 'nvim-telescope/telescope-live-grep-args.nvim' },
    },
    config = function()
        local telescope = require('telescope')
        local lga_actions = require("telescope-live-grep-args.actions")

        telescope.setup({
            defaults = {
                layout_config = {
                    height = vim.o.lines,  -- maximally available lines
                    -- height = 20,
                    width = vim.o.columns, -- maximally available columns
                    prompt_position = "bottom",
                    -- preview_height = 0.6, -- 60% of available lines
                },

                -- -- emulates the ivy layout by default for telescope windows
                layout_strategy = 'flex',
                -- layout_config = {
                --     height = 20,
                -- },
                border = true,
                sorting_strategy = "ascending",
                path_display = {
                    "smart",
                    -- "truncate",
                },
            },
            fzf = {
                fuzzy = true,                   -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true,    -- override the file sorter
                case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            },
            extensions = {
                live_grep_args = {
                    auto_quoting = true, -- enable/disable auto-quoting
                    mappings = { -- extend mappings
                        i = {
                            ["<C-k>"] = lga_actions.quote_prompt(),
                            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                        },
                    },
                }
            }
        })

        require("telescope").load_extension("live_grep_args")
        local builtin = require('telescope.builtin')
        local extensions = telescope.extensions

        -- vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        -- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        -- Search workspace for text string
        -- vim.keymap.set('n', '<leader>ps', function()
        -- 	builtin.grep_string({ search = vim.fn.input(string.format("Search workspace (root: %s) > ", vim.fn.getcwd())) });
        -- end)

        --  local path_display = function(opts, path)
        --     local tail = require("telescope.utils").path_tail(path)
        --     return string.format("%s (%s)", tail, path)
        -- end
        --
        -- local find_files = function ()
        --     builtin.find_files({
        --         path_display = path_display
        --     })
        -- end
        --
        vim.keymap.set('n', '<C-p>', builtin.find_files, { silent = true })
        -- vim.keymap.set('n', '<C-p>', function() builtin.find_files({ path_display = path_display }) end, { silent = true })
        vim.keymap.set('n', '<leader>fg', builtin.git_files, { silent = true })
        -- this version of live grep allows to pass args
        vim.keymap.set('n', '<leader>fl', extensions.live_grep_args.live_grep_args, { silent = true })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { silent = true })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { silent = true })
        -- Open telescope diagnostic window
        vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>Telescope diagnostics<CR>', { noremap = true, silent = true })

        vim.keymap.set('n', '<leader>ff', '<cmd>Telescope<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>fa', '<cmd>Telescope find_files hidden=true<CR>', { noremap = true, silent = true })
        -- vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
        -- vim.keymap.set('n', '<leader>fl', builtin.live_grep, {})
        -- vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        -- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        -- vim.keymap.set('n', '<leader>fs', function()
        --     builtin.grep_string({ search = vim.fn.input(string.format("Search workspace (root: %s) > ", vim.fn.getcwd())) });
        -- end)
    end
}
