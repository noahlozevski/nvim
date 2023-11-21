return {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        vim.opt.list = true
        -- vim.opt.listchars:append "space:⋅"
        -- vim.opt.listchars:append "eol:↴"

        require("ibl").setup {
            indent = { char = " " },
            scope = {
                show_exact_scope = true,
                show_start = false
            }
            -- space_char_blankline = " ",
            -- show_current_context = true,
            -- show_current_context_start = false,
        }
    end
}
