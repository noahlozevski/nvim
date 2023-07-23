return {
    'johmsalas/text-case.nvim',
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        require('textcase').setup {}
        require('telescope').load_extension('textcase')
        vim.api.nvim_set_keymap('n', '<leader>ct', '<cmd>TextCaseOpenTelescope<CR>',
            { desc = "Change Text (Telescope Menu)" })
        vim.api.nvim_set_keymap('v', '<leader>ct', "<cmd>TextCaseOpenTelescope<CR>",
            { desc = "Change Text (Telescope Menu)" })
    end
}
