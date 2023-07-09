local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePost" -- or "BufWritePost"
local async = event == "BufWritePost"

-- local allowed_format_servers = {
--     -- 'tsserver',
--     -- 'eslint',
--     'rust_analyzer',
--     'lua_ls',
--     'null-ls'
--     -- 'prettier',
-- }
-- local function allow_format(servers)
--     return function(client) return vim.tbl_contains(servers, client.name) end
-- end
return {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local null_ls = require("null-ls")

        -- register any number of sources simultaneously
        local sources = {
            -- js / ts
            null_ls.builtins.formatting.prettierd.with({ prefer_local = true }),
            -- null_ls.builtins.diagnostics.eslint_d,
            null_ls.builtins.code_actions.eslint_d,

            -- generic
            null_ls.builtins.hover.dictionary,

            -- c / cpp
            null_ls.builtins.formatting.clang_format,
            null_ls.builtins.diagnostics.cppcheck,
            -- null_ls.builtins.diagnostics.clang_check,
            null_ls.builtins.formatting.uncrustify
        }

        -- Keymappings
        vim.api.nvim_set_keymap('n', '<leader>da', '<cmd>lua vim.lsp.buf.code_action()<CR>',
        { noremap = true, silent = true })

        null_ls.setup({
            sources = sources,
            -- on_attach = function(client, bufnr)
            --     -- Enable formatting on sync
            --     if client.supports_method("textDocument/formatting") then
            --         local format_on_save = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
            --         vim.api.nvim_create_autocmd('BufWritePre', {
            --             group = format_on_save,
            --             buffer = bufnr,
            --             callback = function()
            -- vim.lsp.buf.format({
            --     bufnr = bufnr,
            --     filter = function(_client)
            --         return _client.name == "null-ls"
            --     end
            -- })
            --             end,
            --         })
            --     end
            -- end
           on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.keymap.set("n", "<leader>f", function()
                        vim.lsp.buf.format({
                            bufnr = vim.api.nvim_get_current_buf(),
                            filter = function(_client)
                                return _client.name == "null-ls"
                            end
                        })
                    end, { buffer = bufnr, desc = "[lsp] format" })

                    -- format on save
                    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
                    vim.api.nvim_create_autocmd(event, {
                        buffer = bufnr,
                        group = group,
                        callback = function()
                            vim.lsp.buf.format({
                                bufnr = bufnr,
                                async = true,
                                filter = function(_client)
                                    return _client.name == "null-ls"
                                end
                            })
                        end,
                        desc = "[lsp] format on save",
                    })
                end

                if client.supports_method("textDocument/rangeFormatting") then
                    vim.keymap.set("x", "<leader>f", function()
                        vim.lsp.buf.format({
                            bufnr = vim.api.nvim_get_current_buf(),
                            filter = function(_client)
                                return _client.name == "null-ls"
                            end
                        })
                    end, { buffer = bufnr, desc = "[lsp] format" })
                end
            end,

        })
    end
}
