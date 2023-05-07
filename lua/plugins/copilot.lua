return {
    'github/copilot.vim',
    config = function () 
        vim.g.copilot_assume_mapped = true

        -- Accepts the completion
        vim.api.nvim_set_keymap("i", "<C-Space>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end
}
