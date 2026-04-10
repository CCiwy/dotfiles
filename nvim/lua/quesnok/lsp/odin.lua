vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.odin",
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})


vim.lsp.config('ols', {
    cmd = { "odinls" },
    init_options = {
        checker_args = "-strict-style",
        collections = {
            { name = "shared", path = vim.fn.expand("$HOME/odin-lib") },
        },
        enable_format = true,
        enable_hover = true,
        enable_document_symbols = true,
        enable_semantic_tokens = true,
        enable_inlay_hints = true,
        formatter = {
            style = "stroustrup",  -- Brace style
        },
    },
})
