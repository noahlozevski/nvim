return {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    -- dependencies =  {
    --     { 'nvim-telescope/telescope.nvim'},
    -- },
    config = function ()
        -- Load fzf extension for telescope
        require('telescope').load_extension('fzf')


        -- vim.keymap.set("n", "<C-P>", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
        -- vim.keymap.set("n", "<C-\>", "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })
        -- vim.keymap.set("n", "<c-P>", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
        -- vim.keymap.set("n", "<c-P>", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
        -- vim.keymap.set("n", "<c-P>", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
        --
        -- vim.g.fzf_preview_window = ["right,50%", "ctrl-/"]
        --
        -- vim.keymap.set('n', '<C-p>', "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
        -- -- vim.keymap.set('n', '<C-p>', "<cmd>FZF<CR>", { silent = true })
        -- -- vim.keymap.set('n', '<leader>ff', "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
        -- vim.keymap.set('n', '<leader>fg', "<cmd>lua require('fzf-lua').git_files()<CR>", { silent = true })
        -- vim.keymap.set('n', '<leader>fl', "<cmd>lua require('fzf-lua').live_grep()<CR>", { silent = true })
        -- vim.keymap.set('n', '<leader>fb', "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })
        -- vim.keymap.set('n', '<leader>fh', "<cmd>lua require('fzf-lua').help_tags()<CR>", { silent = true })
    end
}
