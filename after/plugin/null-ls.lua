local null_ls = require("null-ls")

-- register any number of sources simultaneously
local sources = {
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.formatting.prettier_d_slim,
    null_ls.builtins.hover.dictionary
}

-- Keymappings
vim.api.nvim_set_keymap('n', '<leader>da', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })

null_ls.setup({ sources = sources })
