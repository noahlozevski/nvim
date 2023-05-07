local function showFugitiveGit()
    if vim.fn.FugitiveHead() ~= '' then
        vim.cmd [[
        Git
        " wincmd H  " Open Git window in vertical split
        " setlocal winfixwidth
        " vertical resize 31
        " setlocal winfixwidth
        setlocal nonumber
        setlocal norelativenumber
        ]]
    end
end
local function toggleFugitiveGit()
    if vim.fn.buflisted(vim.fn.bufname('fugitive:///*/.git//$')) ~= 0 then
        vim.cmd [[ execute ":bdelete" bufname('fugitive:///*/.git//$') ]]
    else
        showFugitiveGit()
    end
end

return {
    'tpope/vim-fugitive',
    config = function () 
        vim.keymap.set("n", "<C-i>", toggleFugitiveGit)
        -- vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        -- vim.keymap.set('n', '<F3>', toggleFugitiveGit, opts)
    end
}
