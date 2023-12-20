return {
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    -- TODO: figure out issues with lazy loading
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        { 'hrsh7th/cmp-nvim-lsp' },              -- Required
        { 'williamboman/mason-lspconfig.nvim' }, -- Optional
        {
            'williamboman/mason.nvim',
            build = function()
                pcall(vim.cmd, 'MasonUpdate')
            end
        },
        { 'lukas-reineke/lsp-format.nvim' }, -- Required for async format on save
        { 'hrsh7th/cmp-nvim-lsp-signature-help' },
        { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
        {
            'creativenull/efmls-configs-nvim',
            version = 'v1.x.x', -- version is optional, but recommended
            dependencies = { 'neovim/nvim-lspconfig' },
        }
    },
    config = function()
        -- load lsp config
        require('lozevski.lsp')
    end
}
