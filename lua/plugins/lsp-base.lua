return {
    'VonHeikemen/lsp-zero.nvim',
    lazy = true,
    branch = 'v2.x',
    config = function()
        require('lsp-zero').preset({})
    end
}
