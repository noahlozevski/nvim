-- Set up nvim-cmp.
local cmp = require 'cmp'
local compare = require('cmp.config.compare')

-- Helpers for the matching methods
local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local completion_source_icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = ""
}


cmp.setup({
    experimental = {
        ghost_text = false,
    },
    formatting = {
        format = function(entry, vim_item)
            local lspkind_ok, lspkind = pcall(require, "lspkind")
            if not lspkind_ok then
                -- From kind_icons array
                vim_item.kind = string.format('%s %s', completion_source_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
                -- Source
                vim_item.menu = ({
                    buffer = "[Buffer]",
                    fuzzy_buffer = "[Buffer]",
                    nvim_lsp = "[LSP]",
                    vsnip = "[VSnip]",
                    nvim_lua = "[Lua]",
                })[entry.source.name]
                return vim_item
            else
                -- From lspkind
                return lspkind.cmp_format()
            end
        end
    },
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` us
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    sorting = {
        -- Need this override for cmp fuzzy buffer
        -- Need to do the same thing for fuzzy path if enabled
        priority_weight = 2,
        comparators = {
            require('cmp_fuzzy_buffer.compare'),
            compare.offset,
            compare.exact,
            compare.score,
            -- require("cmp-under-comparator").under,
            compare.recently_used,
            compare.kind,
            compare.sort_text,
            compare.length,
            compare.order,
        }
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        -- this is supposed to be 'safe' enter key mapping
        -- ["<CR>"] = cmp.mapping({
        --     i = function(fallback)
        --         if cmp.visible() and cmp.get_active_entry() then
        --             cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        --         else
        --             fallback()
        --         end
        --     end,
        --     s = cmp.mapping.confirm({ select = true }),
        --     c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
        -- }),
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
        -- https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
        { name = 'nvim_lsp_signature_help' },
        -- { name = 'calc' }, cant get this to work but would be cool ???
        { name = 'fuzzy_buffer' },
        { name = 'zsh' },
        { name = 'tmux' },
        { name = 'emoji' },
        { name = 'nvim_lua' },

    }, {
        -- buffer results usually arent as helpful
        { name = 'buffer', keyword_length = 2 },
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'fuzzy_buffer', keyword_length = 2 },
    })
})

cmp.setup.cmdline('?', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'fuzzy_buffer', keyword_length = 2 }
    }
})

cmp.setup.cmdline('/', {
    sources = cmp.config.sources({
        { name = 'nvim_lsp_document_symbol' }
    }, {
        { name = 'fuzzy_buffer', keyword_length = 2 }
    })
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'fuzzy_buffer', keyword_length = 2 },
        { name = 'async_path' },
    }, {
        { name = 'cmdline' }
    })
})
