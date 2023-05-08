-- keeping this in the after as a big file so i can toggle / modify without having to navigate
function startCatppuccin()
    require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = {
            -- :h background
            light = "frappe",
            dark = "mocha"
        },
        transparent_background = true,
        show_end_of_buffer = true, -- show the '~' characters after the end of buffers
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
    vim.cmd.colorscheme("catppuccin")
end

function startTokyoNight()
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
    vim.cmd.colorscheme("tokyonight")
end

function startOxocarbon()
    vim.cmd([[ let g:aurora_transparent = 1 ]])
    -- vim.cmd([[ let g:aurora_darker = 1 ]])
    vim.cmd.colorscheme("oxocarbon")
end

function startAurora()
    vim.cmd.colorscheme("aurora")
end

function startRosePine()
    require('rose-pine').setup({
        --- @usage 'auto'|'main'|'moon'|'dawn'
        variant = 'moon',
        --- @usage 'main'|'moon'|'dawn'
        dark_variant = 'moon',
        bold_vert_split = false,
        dim_nc_background = false,
        disable_background = true,
        disable_float_background = true,
        disable_italics = true,
        --- @usage string hex value or named color from rosepinetheme.com/palette
        groups = {
            -- background = 'base',
            -- background_nc = '_experimental_nc',
            -- panel = 'surface',
            -- panel_nc = 'base',
            -- border = 'highlight_med',
            -- comment = 'muted',
            -- link = 'iris',
            -- punctuation = 'subtle',
            -- error = 'love',
            -- hint = 'iris',
            -- info = 'foam',
            -- warn = 'gold',
            -- headings = {
            --     h1 = 'iris',
            --     h2 = 'foam',
            --     h3 = 'rose',
            --     h4 = 'gold',
            --     h5 = 'pine',
            --     h6 = 'foam',
            -- }
            -- -- or set all headings at once
            -- -- headings = 'subtle'
        },
        -- Change specific vim highlight groups
        -- https://github.com/rose-pine/neovim/wiki/Recipes
        highlight_groups = {
            -- ColorColumn = { bg = 'rose' },
            -- Blend colours against the "base" background
            CursorLine = { bg = 'foam', blend = 10 },
            StatusLine = { fg = "rose", bg = "iris", blend = 10 },
            StatusLineNC = { fg = "subtle", bg = "surface" },
            TelescopeBorder = { fg = "highlight_high", bg = "none" },
            TelescopeNormal = { bg = "none" },
            TelescopePromptNormal = { bg = "base" },
            TelescopeResultsNormal = { fg = "subtle", bg = "none" },
            TelescopeSelection = { fg = "text", bg = "base" },
            TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
        }
    })
    vim.cmd.colorscheme("rose-pine")
end

function startMoonfly()
    vim.cmd.colorscheme("moonfly")
end

function startNightfly()
    vim.cmd.colorscheme("nightfly")
end

function startRESETTTTT()
    -- reset to default
    vim.cmd.colorscheme("default")
end

vim.opt.background = "dark"

local themers = {
    startRosePine,
    startCatppuccin,
    startAurora,
    startMoonfly,
    startNightfly,
    startOxocarbon,
    startTokyoNight,
    startRESETTTTT,
}

local current = 0;
function toggle_theme()
    current = current + 1
    themers[current]()
    if current == #themers then
        current = 0
    end
end

local color = "dark"
function toggle_light_dark()
    if color == "dark" then
        vim.opt.background = "light"
        color = "light"
    elseif color == "light" then
        vim.opt.background = "dark"
        color = "dark"
    end
end

vim.keymap.set(
"",
"<leader>tl",
toggle_light_dark,
{ desc = "Toggle light / dark mode" }
)

vim.keymap.set(
"",
"<leader>tt",
toggle_theme,
{ desc = "Toggle theme" }
)

-- start default / first theme
themers[1]()
