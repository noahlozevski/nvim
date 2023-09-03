return {
    'johmsalas/text-case.nvim',
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        require('textcase').setup {}
        require('telescope').load_extension('textcase')

        -- vim.api.nvim_set_keymap('n', '<leader>cc', '<cmd>TextCaseOpenTelescope<CR>',
        --     { desc = "Change Text (Telescope Menu)" })
        -- vim.api.nvim_set_keymap('v', '<leader>cc', "<cmd>TextCaseOpenTelescope<CR>",
        --     { desc = "Change Text (Telescope Menu)" })

        vim.keymap.set({ 'n', 'v' }, 'gaa', "<cmd>TextCaseOpenTelescopeQuickChange<CR>",
            { desc = "Telescope Quick Change" })
        vim.keymap.set({ 'n', 'v' }, 'gal', "<cmd>TextCaseOpenTelescopeLSPChange<CR>",
            { desc = "Telescope LSP Change" })
    end
}
