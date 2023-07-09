return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    config = function()
        require('lsp-zero').preset({})
    end
}
