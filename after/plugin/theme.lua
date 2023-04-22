require("catppuccin").setup({
    flavour = "latte", -- latte, frappe, macchiato, mocha
    background = {
        -- :h background
        light = "frappe",
        dark = "mocha"
    },
    transparent_background = false,
    show_end_of_buffer = false, -- show the '~' characters after the end of buffers
    term_colors = true,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15
    },
    no_italic = false, -- Force no italic
    no_bold = false,   -- Force no bold
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {}
    },
    color_overrides = {
        all = {},
        latte = {},
        frappe = {},
        macchiato = {},
        mocha = {}
    },
    integrations = {
        -- <module> = <boolean>
        harpoon = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        -- barbar = true,
        mason = true,
        neotree = true,
        cmp = true,
        lsp_trouble = true
    }
})

require("tokyonight").setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    style = "night",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    light_style = "day",    -- The theme is used when the background is set to light
    transparent = true,     -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
    styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark",            -- style for sidebars, see below
        floats = "dark",              -- style for floating windows
    },
    sidebars = { "qf", "help" },      -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
    day_brightness = 0.3,             -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = false,             -- dims inactive windows
    lualine_bold = false,             -- When `true`, section headers in the lualine theme will be bold
})

local current = 0;
local currentTheme = 'tokyonight'
function toggle_theme()
    if current == 0 then
        currentTheme = 'tokyonight'
    elseif current == 1 then
        currentTheme = "catppuccin"
    end

    vim.cmd.colorscheme(currentTheme)
    current = current + 1
    if current == 2 then
        current = 0
    end
end

vim.keymap.set(
    "",
    "<leader>tt",
    toggle_theme,
    { desc = "Toggle theme" }
)

toggle_theme()
-- function setupStatusBar()
--
-- end

-- for status bar
-- require('lualine').setup({
--     options = {
--         theme = 'tokyonight',
--     },
-- })
