vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.locales",
    command = "set filetype=json"
})

vim.lsp.config('jsonls', { filetypes = {"json", "jsonc"}, init_options = { provideFormatter = true } })

