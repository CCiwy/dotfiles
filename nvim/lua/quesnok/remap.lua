vim.g.mapleader = " "
vim.keymap.set("n", "<leader>c", function()
    require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })


vim.keymap.set('n', '<C-1>', ':wincmd p<CR>')
vim.keymap.set('n', '<C-2>', ':wincmd n<CR>')

vim.keymap.set('n', '<leader>q', ':bd<CR>', {noremap = true})

-- move to splits with control + vim-motion
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-j>', '<C-w>j')


vim.keymap.set("n", "<F5>", function()
    vim.cmd("silent make")
    if #vim.fn.getqflist() > 0 then
        vim.cmd("copen")
    end
end, { desc = "Build and open quickfix" })
