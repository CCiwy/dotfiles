require("quesnok")

-- disable_netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
--|nvim-tree.disable_netrw| `= false`
--|nvim-tree.hijack_netrw| ` = true`

-- COMPLETION SETUP
local cmp = require("cmp")
cmp.setup({
    sources = { { name = 'nvim_lsp' } },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({}),
})


-- DIAGNOSTICS
local diagnostic_signs = {
    Error = '✘',
    Warn = '▲',
    Hint = '⚑',
    Info = '»',
}

for sign, icon in pairs(diagnostic_signs) do
    local hl = 'DiagnosticSign' .. sign
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = ''})
end



vim.diagnostic.config({
    virtual_text = false,  -- Disable inline virtual text (optional)
    float = {
        source = "if_many",  -- Show source of diagnostic message
        wrap = true,        -- Ensure long messages are wrapped
        border = "rounded", -- Add a nice border around the float window
        max_width = math.floor(vim.o.columns * 0.7), -- Limit width to avoid exceeding screen size
        scope = "cursor"
    },
})

vim.api.nvim_create_autocmd("CursorMoved", {
    pattern = "*",
    callback = function()
        if #vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 }) > 0 then
            vim.diagnostic.open_float(nil, { focusable = false })
        end
    end,
})

vim.api.nvim_create_autocmd("TermClose", {
  callback = function(args)
    local buf = args.buf
    vim.schedule(function()
      -- Close any windows that are still showing this terminal buffer
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == buf then
          -- force=true so it closes even if it's the last thing in that split
          pcall(vim.api.nvim_win_close, win, true)
        end
      end

      -- Then delete the buffer (usually already gone, but harmless)
      if vim.api.nvim_buf_is_valid(buf) then
        pcall(vim.api.nvim_buf_delete, buf, { force = true })
      end
    end)
  end,
})
