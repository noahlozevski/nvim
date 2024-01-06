local lsp = require('lsp-zero').preset({})

lsp.ensure_installed({
    -- add more servers / languages
    'tsserver',
    'eslint',
    'rust_analyzer',
    'lua_ls',
    'clangd',
})

lsp.nvim_workspace()

-- local cmp = require('cmp')
-- local cmp_select = { behavior = cmp.SelectBehavior.Select }
-- local cmp_mappings = lsp.defaults.cmp_mappings({
--     ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--     ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--     ['<C-y>'] = cmp.mapping.confirm({ select = true }),
--     -- ["<C-Space>"] = cmp.mapping.complete(),
-- })

-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil

-- lsp.setup_nvim_cmp({
--     mapping = cmp_mappings
-- })

lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        error = '✘',
        warn = '▲',
        hint = '⚑',
        info = '»'
    }
})

-- -- These languages will be formatted on save + will be loaded on start
-- local allowed_format_servers = {
--     -- 'tsserver',
--     -- 'eslint',
--     'clangd',
--     'rust_analyzer',
--     'lua_ls',
--     -- 'null-ls',
--     -- 'html',
--     -- 'css'
--     -- 'prettier',
-- }
-- local function allow_format(servers)
--     return function(client) return vim.tbl_contains(servers, client.name) end
-- end

local function on_attach(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    -- require('lsp-format').on_attach(client)
    -- local opts = { buffer = bufnr, remap = false }
    --
    -- -- This enables auto format on save with all available lsp servers for the file type
    -- -- lsp.buffer_autoformat()
    -- -- Enables async format on save capability for a set of servers
    --
    -- -- -- Asynchronously autoformat the file on save
    -- -- if vim.tbl_contains(allowed_format_servers, client.name) then
    -- --     require('lsp-format').on_attach(client)
    -- -- end
    -- --
    -- -- format the file using default lsp server
    -- -- vim.keymap.set({ 'n', 'x' }, 'gq', function()
    -- --     vim.lsp.buf.format({
    -- --         async = false,
    -- --         timeout_ms = 10000,
    -- --         -- filter = allow_format(allowed_format_servers)
    -- --         -- filter = function(client)
    -- --         --     return client.name ~= 'null-ls'
    -- --         -- end
    -- --     })
    -- -- end)
    --
    -- -- formats the file
    -- -- vim.keymap.set({ 'n', 'x' }, '<leader>f', function() vim.lsp.buf.format() end, { buffer = bufnr, remap = false, desc = "[lsp] format" })
    --
    -- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    -- vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    -- -- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    --
    -- -- Opens a popup with a list of all the diagnostics from the lsp for the current line
    -- vim.api.nvim_set_keymap('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>',
    --     { noremap = true, silent = true })
    --
    -- -- -- Jump to next / previous diagnotic
    -- -- vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    -- vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    -- vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    -- vim.keymap.set("n", "<leader>da", function() vim.lsp.buf.code_action() end, opts)
    -- vim.keymap.set("n", "<leader>dr", function() vim.lsp.buf.references() end, opts)
    -- vim.keymap.set("n", "<leader>dn", function() vim.lsp.buf.rename() end, opts)
    -- vim.keymap.set("n", "<leader>di", function() vim.lsp.buf.implementation() end, opts)
    -- vim.keymap.set("n", "<leader>dc", function() vim.lsp.buf.declaration() end, opts)
    -- -- already mapped to gd
    -- -- vim.keymap.set("n", "<leader>df", function() vim.lsp.buf.definition() end, opts)
    -- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.hoverProvider then
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
        end
        if client.server_capabilities.signatureHelpProvider then
            vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, { buffer = args.buf })
        end
        if client.server_capabilities.declarationProvider then
            vim.keymap.set('n', 'dc', vim.lsp.buf.declaration, { buffer = args.buf })
        end
        if client.server_capabilities.definitionProvider then
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf })
        end
        if client.server_capabilities.typeDefinitionProvider then
            vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, { buffer = args.buf })
        end
        if client.server_capabilities.implementationProvider then
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = args.buf })
        end
        if client.server_capabilities.referencesProvider then
            vim.keymap.set('n', 'dr', vim.lsp.buf.references, { buffer = args.buf })
        end
        if client.server_capabilities.renameProvider then
            vim.keymap.set('n', 'dn', vim.lsp.buf.rename, { buffer = args.buf })
        end
        if client.server_capabilities.codeActionProvider then
            vim.keymap.set('n', '<leader>da', vim.lsp.buf.code_action, { buffer = args.buf })
        end

        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = args.buf })
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = args.buf })
        -- vim.keymap.set("n", "<leader>do", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, { buffer = args.buf })
        vim.api.nvim_create_user_command('Dllist', vim.diagnostic.setloclist, {})
        vim.api.nvim_create_user_command('Dclist', vim.diagnostic.setqflist, {})
    end,
})
lsp.on_attach = on_attach

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
local lspconfig = require('lspconfig')
-- local configured_servers = {
--     -- 'tsserver',
--     -- 'eslint',
--     'clangd',
--     'rust_analyzer',
--     'lua_ls',
--     'kotlin_language_server',
--     -- 'shfmt',
--     -- 'null-ls',
-- }

-- for i, server in ipairs(configured_servers) do
--     -- lspconfig[server].setup {
--     --     on_attach = on_attach,
--     --     capabilities = capabilities
--     -- }
-- end

local function filter(arr, fn)
    if type(arr) ~= "table" then
        return arr
    end

    local filtered = {}
    for k, v in pairs(arr) do
        if fn(v, k, arr) then
            table.insert(filtered, v)
        end
    end

    return filtered
end

local function filterReactDTS(value)
    return string.match(value.targetUri, '%.d.ts') == nil
end

require("mason").setup()
require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities
        }
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    ["clangd"] = function()
        lspconfig.clangd.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = {
                "clangd",
                "--offset-encoding=utf-16",
            },
        }
    end,
    ["tsserver"] = function()
        lspconfig.tsserver.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact',
                'typescript.tsx' },
            handlers = {
                ['textDocument/definition'] = function(err, result, method, ...)
                    if vim.tbl_islist(result) and #result > 1 then
                        local filtered_result = filter(result, filterReactDTS)
                        return vim.lsp.handlers['textDocument/definition'](err, filtered_result, method, ...)
                    end
                    vim.lsp.handlers['textDocument/definition'](err, result, method, ...)
                end

            }
        }
    end,
    ["eslint"] = function()
        lspconfig.eslint.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact',
                'typescript.tsx' },
        }
    end,
    ["lua_ls"] = function()
        -- Fixes the undefined vim global annoyance
        lspconfig.lua_ls.setup {
            settings = {
                Lua = {
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = {
                            'vim',
                            'augroup',
                            'require'
                        },
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        }
    end,
    ["efm"] = function()
        local eslint = require('efmls-configs.linters.eslint_d')
        local prettier = require('efmls-configs.formatters.prettier_d')

        -- EFM formatting language specs
        local languages = require('efmls-configs.defaults').languages()

        languages = vim.tbl_extend('force', languages, {
            typescript = { eslint, prettier },
            ["typescript.jsx"] = { eslint, prettier },
            typescriptreact = { eslint, prettier },
            javascript = { eslint, prettier },
            ["javascript.jsx"] = { eslint, prettier },
            javascriptreact = { eslint, prettier }
        })

        -- manual lsp config must come after mason-lspconfig
        -- EFM for eslint / prettier / formatting stuff
        lspconfig.efm.setup {
            filetypes = vim.tbl_keys(languages),
            init_options = {
                documentFormatting = true,
                documentRangeFormatting = true,
            },
            settings = {
                rootMarkers = { ".git/" },
                languages = languages
            }
        }
    end,
}


-- require("lspconfig").clangd.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     cmd = {
--         "clangd",
--         "--offset-encoding=utf-16",
--     },
-- }



-- lspconfig.tsserver.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
--     handlers = {
--         ['textDocument/definition'] = function(err, result, method, ...)
--             if vim.tbl_islist(result) and #result > 1 then
--                 local filtered_result = filter(result, filterReactDTS)
--                 return vim.lsp.handlers['textDocument/definition'](err, filtered_result, method, ...)
--             end
--
--             vim.lsp.handlers['textDocument/definition'](err, result, method, ...)
--         end
--
--     }
-- }

-- lspconfig.eslint.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
-- }
-- -- Fixes the undefined vim global annoyance
-- lspconfig.lua_ls.setup {
--     settings = {
--         Lua = {
--             diagnostics = {
--                 -- Get the language server to recognize the `vim` global
--                 globals = {
--                     'vim',
--                     'augroup',
--                     'require'
--                 },
--             },
--             telemetry = {
--                 enable = false,
--             },
--         },
--     },
-- }


local function get_store_kit_lsp_path()
    local isMac = vim.loop.os_uname().sysname == "Darwin"
    if isMac then
        local sourceKitPath = vim.fn.system("xcrun --find sourcekit-lsp")
        if sourceKitPath then
            return sourceKitPath:gsub("%s+", "")
        end
    end
    return "sourcekit-lsp"
end



-- swift lsp setup, needs to be seperate from mason since sourcekit isnt supported there
local swift_lsp = vim.api.nvim_create_augroup("swift_lsp", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "swift" },
    callback = function()
        local root_dir = vim.fs.dirname(vim.fs.find({
            "Package.swift",
            ".git"
        }, { upward = true })[1])
        local sourceKitPath = get_store_kit_lsp_path()
        local client = vim.lsp.start({
            name = "sourcekit-lsp",
            cmd = { sourceKitPath },
            root_dir = root_dir,
        })
        vim.lsp.buf_attach_client(0, client)
    end,
    group = swift_lsp,
})


pcall(require, 'lozevski.lsp.work')

lsp.setup()

return {
    on_attach = on_attach
}
