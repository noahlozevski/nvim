-- only configure cmp plugins here (dont make dependencies on lsp)
-- require('lsp-zero.cmp').extend()

local cmp = require('cmp')
local compare = require('cmp.config.compare')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local function border(hl_name)
    return {
        { "╭", hl_name },
        { "─", hl_name },
        { "╮", hl_name },
        { "│", hl_name },
        { "╯", hl_name },
        { "─", hl_name },
        { "╰", hl_name },
        { "│", hl_name },
    }
end

local fuzzy_buffer_conf = {
    name = 'fuzzy_buffer',
    keyword_length = 3,
    option = {
        max_matches = 2,
        -- pull from all loaded buffers
        get_bufnrs = function()
            local bufs = {}
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
                if buftype ~= 'nofile' and buftype ~= 'prompt' then
                    bufs[#bufs + 1] = buf
                end
            end
            return bufs
        end
    }
}

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' },
    }, {
        fuzzy_buffer_conf,
    })
})

cmp.setup.cmdline('?', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        fuzzy_buffer_conf,
    }
})

cmp.setup.cmdline('/', {
    sources = cmp.config.sources({
        { name = 'nvim_lsp_document_symbol' }
    }, {
        { name = "rg" },
        {
            name = 'fuzzy_buffer',
            -- no keyword length to find matches when replacing
            option = {
                max_matches = 5,
            }
        }
    })
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'cmdline' },
        { name = 'async_path' },
        { name = 'zsh', },
        { name = "cmdline_history" },
    },
    {
        fuzzy_buffer_conf
    })
})

local opts = {
    experimental = {
        ghost_text = false,
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        -- format = require('lspkind').cmp_format({
        --     mode = 'symbol_text',
        --     maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        --     ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
        --     preset = 'default',
        --     before = function(entry, vim_item)
        --         -- This gives info about the source of the completion
        --         vim_item.menu = ({
        --             buffer = "Buffer",
        --             fuzzy_buffer = "Buffer",
        --             nvim_lsp = "LSP",
        --             vsnip = "VSnip",
        --             nvim_lua = "Lua",
        --         })[entry.source.name]
        --
        --         return vim_item
        --     end
        -- })
        format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({
                mode = "symbol_text",
                maxwidth = 50,
                ellipsis_char = '...',
                preset = 'default',
            })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            local menu = ({
                buffer = "Buffer",
                fuzzy_buffer = "Buffer",
                nvim_lsp = "LSP",
                vsnip = "VSnip",
                nvim_lua = "Lua",
            })[entry.source.name] or strings[2] or ""
            kind.menu = "    (" .. (menu) .. ")"
            return kind
        end,
    },
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered({
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -3,
            side_padding = 0,
            scrollbar = false,
        }),
        documentation = {
            border = border "CmpDocBorder",
            winhighlight = "Normal:CmpDoc",
        },
    },
    sorting = {
        -- -- Need this override for cmp fuzzy buffer
        -- -- Need to do the same thing for fuzzy path if enabled
        -- priority_weight = 2,
        -- comparators = {
        --     require('cmp_fuzzy_buffer.compare'),
        --     compare.offset,
        --     compare.exact,
        --     compare.score,
        --     -- require("cmp-under-comparator").under,
        --     compare.recently_used,
        --     compare.kind,
        --     compare.sort_text,
        --     compare.length,
        --     compare.order,
        -- }
        priority_weight = 2,
        comparators = {
            require('cmp_fuzzy_buffer.compare'),
            compare.offset,
            compare.exact,
            compare.score,
            compare.recently_used,
            compare.kind,
            compare.sort_text,
            compare.length,
            compare.order,
        }
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        -- ["<C-Space>"] = cmp.mapping.complete(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        -- close the suggestion menu
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
        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_next_item()
        --     elseif vim.fn["vsnip#available"](1) == 1 then
        --         feedkey("<Plug>(vsnip-expand-or-jump)", "")
        --     elseif has_words_before() then
        --         cmp.complete()
        --     else
        --         fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        --     end
        -- end, { "i", "s" }),
        -- ["<S-Tab>"] = cmp.mapping(function()
        --     if cmp.visible() then
        --         cmp.select_prev_item()
        --     elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        --         feedkey("<Plug>(vsnip-jump-prev)", "")
        --     end
        -- end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'calc' }, cant get this to work but would be cool ???
        -- { name = 'tmux' },
        -- { name = 'emoji' },
        { name = 'nvim_lua' },
    },
    {
        { name = 'nvim_lsp_signature_help' },
    },
    {
        { name = 'async_path' },
        -- pulls strings from whole workspace
        { name = "rg" },
        -- buffer results usually arent as helpful
        -- { name = 'buffer' },
        fuzzy_buffer_conf,
    })
}


cmp.setup(opts)
cmp.setup.cmdline(opts)
cmp.setup.buffer(opts)
