local oil = require("oil")
local actions = require("oil.actions")
local preview_shown = false

local function close_preview()
    actions.preview.callback()
    preview_shown = false
    vim.keymap.set("n", "<C-u>", "<C-u>zz", { buffer = true })
    vim.keymap.set("n", "<C-d>", "<C-d>zz", { buffer = true })
end

local function open_preview()
    actions.preview.callback()
    preview_shown = true
    vim.keymap.set("n", "<C-u>", actions.preview_scroll_up.callback, { buffer = true })
    vim.keymap.set("n", "<C-d>", actions.preview_scroll_down.callback, { buffer = true })
end

vim.keymap.set(
    "n",
    "<Esc>",
    function()
        if preview_shown then
            close_preview()
        else
            -- close the floating window, if present
            oil.toggle_float()
        end
    end,
    {
        desc = "Toggle oil float window",
        silent = false,
        buffer = true
    }
)

vim.keymap.set(
    "n",
    "P",
    function()
        if preview_shown then
            close_preview()
        else
            open_preview()
        end
    end,
    {
        desc = "Toggle oil float window",
        silent = false,
        buffer = true
    }
)
