return {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        vim.opt.list = true
        -- vim.opt.listchars:append "space:⋅"
        -- vim.opt.listchars:append "eol:↴"

        require("ibl").setup {
            indent = {
                char = "▏",
                smart_indent_cap = true,
                priority = 1,
            },
            scope = {
                enabled = true,
                show_start = true,
                show_exact_scope = true,
                injected_languages = true,
            },
        }
    end
}
