-- Run :lua LspLines to activate
function LspLines()
    -- Enable lsp lines
    require("lsp_lines").setup({
        virtual_lines = false -- start disabled
    })

    -- keymap for toggling the lines
    vim.keymap.set(
        "",
        "<Leader>l",
        require("lsp_lines").toggle,
        { desc = "Toggle lsp_lines" }
    )
end
