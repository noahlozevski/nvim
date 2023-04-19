require("lsp_lines").setup({
    virtual_lines = false -- start disabled
})



local current = 0;
function toggleDiagnostics()
    if current == 0 then
        -- disable lines and text
        vim.diagnostic.config({ virtual_lines = false, virtual_text = false })
    elseif current == 1 then
        vim.diagnostic.config({ virtual_lines = true, virtual_text = false })
    elseif current == 2 then
        vim.diagnostic.config({ virtual_lines = false, virtual_text = true })
    end
    current = current + 1
    if current == 3 then
        current = 0
    end
end

-- keymap for toggling the lines
vim.keymap.set(
    "",
    "<leader>l",
    toggleDiagnostics,
    { desc = "Toggle lsp_lines" }
)
