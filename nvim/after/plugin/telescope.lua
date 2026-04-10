local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>gR', builtin.grep_string, {})
vim.keymap.set('n', '<leader>gr', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end
)

vim.keymap.set('n', '<leader>bb', builtin.buffers, {})

-- telescope layout
require('telescope').setup({
    defaults = {
        layout_config = {
            horizontal = {
                width = 0.95,
                height = 0.6,
                prompt_position = 'top',
            },
            mirror = true,
        },
    },
    pickers = {
        find_files = {
            theme = "dropdown",
            layout_strategy = 'vertical',
            layout_config = {
                width = function(_, cols, _) return cols end,                 -- all columns
                height = function(_, _, lines) return math.floor(lines * .95) end,
                preview_height = 0.65,
                preview_cutoff = 0,
            },
        }
    },
})
