local common = require('quesnok.lsp.common')

vim.lsp.config('jedi_language_server', {
    init_options = {
        completion = { fuzzy = true, eager = true },
        workspace = { symbols = { ignoreFolders = {} } }
    },

    on_attach = common.extend_on_attach(function(_, bufnr)
        -- Rebind the "textDocument/implementation" keybinding
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = 'Go to references' })
    end),
})


-- Python RUFF formatting
vim.lsp.config('ruff', {
    on_attach = common.extend_on_attach(function(client)
        client.server_capabilities.documentFormattingProvider = true
    end),
})
