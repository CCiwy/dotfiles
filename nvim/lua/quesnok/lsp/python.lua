local common = require('quesnok.lsp.common')

vim.lsp.config('basedpyright', {
    settings = {
        basedpyright = {
            analysis = {
                autoImportCompletions = true,
                typeCheckingMode = "standard",
                useLibraryCodeForTypes = true,
            },
        },
    },

    on_attach = common.extend_on_attach(function(_, bufnr)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = 'Go to references' })
    end),
})


-- Python RUFF formatting
vim.lsp.config('ruff', {
    on_attach = common.extend_on_attach(function(client)
        client.server_capabilities.documentFormattingProvider = true
    end),
})
