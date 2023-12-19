-- vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
-- vim.opt.guicursor = "n-v-c-i:block"
vim.opt.guicursor = "a:blinkon0"
vim.opt.nu = true
vim.opt.relativenumber = true

-- vim.opt.autochdir = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- sets how many lines of suggestions to show in the popup menu
-- vim.opt.pumheight = 25
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 8
vim.opt.scrolloff = 8
-- vim.opt.signcolumn = "auto"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 250

vim.opt.colorcolumn = "80"

-- global statusline
vim.opt.laststatus = 3
vim.wo.cursorline = true
vim.opt.statusline = " %f %m %= %l:%c ♥ "

vim.opt.showmatch = true          -- Highlight matching parenthesis
vim.opt.clipboard = 'unnamedplus' -- Copy/paste to system clipboard

vim.opt.splitright = true         -- Vertical split to the right
vim.opt.splitbelow = true         -- Horizontal split to the bottom
vim.opt.smartcase = true          -- Ignore lowercase for the whole pattern
vim.opt.hidden = true             -- Enable background buffers
vim.opt.history = 100             -- Remember N lines in history
vim.opt.lazyredraw = true         -- Faster scrolling
vim.opt.synmaxcol = 240           -- Max column for syntax highlight

-- disable netrw banner
vim.g.netrw_banner = 0

-- -- Disable builtin plugins
local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    -- "netrw",
    -- "netrwPlugin",
    -- "netrwSettings",
    -- "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
    "tutor",
    "rplugin",
    "synmenu",
    "optwin",
    "compiler",
    "bugreport",
    "ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

-- add highlight on yank
vim.cmd([[
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=100}
augroup END
]])

vim.cmd([[
    if argc() == 1 && isdirectory(argv(0)) | cd `=argv(0)` | endif
]])

-- vim.cmd([[
-- augroup cdpwd
--     autocmd!
--     autocmd VimEnter * cd $PWD
-- augroup END
-- ]])

-- -- This enables the diagnostic hover if the cursor is over the relevant text
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]
--
-- -- This enables the hover window automatically if the the cursor is anywhere in the line
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
--
