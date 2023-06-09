vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

local no_remap = function(lhs, rhs)
	vim.api.nvim_set_keymap('', lhs, rhs, { noremap = true, silent = true })
end

no_remap("<Up>", "<Nop>")
no_remap("<Down>", "<Nop>")
no_remap("<Left>", "<Nop>")
no_remap("<Right>", "<Nop>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "<leader>y", [["jyy]])
vim.keymap.set("v", "<leader>y", [["jy]])
vim.keymap.set("n", "<leader>Y", [["Jyy]])
vim.keymap.set("v", "<leader>Y", [["Jy]])

-- delete and skip register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Align control + c to esc
vim.keymap.set("i", "<C-c>", "<Esc>")

-- vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
--
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
--
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
--
-- vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>");
-- vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");
--
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

--[[ shortcuts for windows
<Ctrl-W>+v       # Opens a new vertical split
<Ctrl-W>+s       # Opens a new horizontal split
<Ctrl-W>+c       # Closes a window
<Ctrl-W>+o       # Makes current window the only one on screen and closes other windows
<Ctrl-W>+h/j/k/l # Moves the cursor to left/bottom/top/right
 ]]
