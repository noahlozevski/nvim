local lsp = require('lsp-zero').preset('recommended')

lsp.ensure_installed({
    -- add more servers / languages
    'tsserver',
    'eslint',
    'rust_analyzer',
    'lua_ls',
})

lsp.nvim_workspace()

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        error = '✘',
        warn = '▲',
        hint = '⚑',
        info = '»'
    }
})

local allowed_format_servers = {
    'tsserver',
    'eslint',
    'rust_analyzer',
    'lua_ls'
}
local function allow_format(servers)
    return function(client) return vim.tbl_contains(servers, client.name) end
end

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    lsp.default_keymaps({ buffer = bufnr })
    -- This enables auto format on save with all available lsp servers for the file type
    -- lsp.buffer_autoformat()
    -- Enables async format on save capability for a set of servers

    -- Asynchronously autoformat the file on save
    if vim.tbl_contains(allowed_format_servers, client.name) then
        require('lsp-format').on_attach(client)
    end

    -- format the file
    vim.keymap.set({ 'n', 'x' }, 'gq', function()
        vim.lsp.buf.format({
            async = false,
            timeout_ms = 10000,
            filter = allow_format(allowed_format_servers)
        })
    end)

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

vim.diagnostic.config({
    -- virtual_text = {
    --     source = 'if_many',
    --     prefix = '●',
    -- },
    virtual_text = true,
    severity_sort = true,
})


-- Set up lspconfig for each server
local capabilities = require('cmp_nvim_lsp').default_capabilities()
for i, server in ipairs(allowed_format_servers) do
    require('lspconfig')[server].setup {
        capabilities = capabilities
    }
end
