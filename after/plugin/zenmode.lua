require("zen-mode").setup {
    window = {
        -- Width in pixels
        width = 100,
        options = {}
    },
}

vim.keymap.set("n", "<leader>zz", require("zen-mode").toggle)
-- vim.wo.wrap = false
-- vim.wo.number = true
-- vim.wo.rnu = true

-- vim.keymap.set("n", "<leader>zZ", function()
--     require("zen-mode").setup {
--         window = {
--             width = 80,
--             options = {}
--         },
--     }
--
--     require("zen-mode").toggle()
--     vim.wo.wrap = false
--     vim.wo.number = true
--     vim.wo.rnu = false
--     vim.opt.colorcolumn = "0"
-- end)
