local oil = require("oil")

vim.keymap.set(
    "n",
    "<Esc>",
    function()
        oil.toggle_float()
    end,
    {
        desc = "Toggle oil float window",
        silent = false,
        buffer = true
    }
)
