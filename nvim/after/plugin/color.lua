vim.opt.background = "dark"

vim.cmd("colorscheme onedark")

local bg_color_hl = "#163626"
local bg_color = "#282c34"

-- highlight on insert mode
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
    callback = function()
        vim.api.nvim_set_hl(0, "Normal",  {bg=bg_color_hl})
    end
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    callback = function()
        vim.api.nvim_set_hl(0, "Normal",  {bg=bg_color})
    end
})


vim.api.nvim_set_hl(0, "CursorLineNr", {
    fg = "#E6C384",
    bold = true,
})

vim.api.nvim_set_hl(0, "CursorLine", {
    bg = "#2A2A2A",
})

