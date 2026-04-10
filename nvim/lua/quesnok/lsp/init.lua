require('quesnok.lsp.clang')
require('quesnok.lsp.lua_lsp')
require('quesnok.lsp.odin')
require('quesnok.lsp.python')
require('quesnok.lsp.typescript')


-- Enhanced capabilities for LSPs
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities()

-- LSP servers enabled by default
local servers = {
    'clang',
    'jedi_language_server',
    'lua_ls',
    'eslint',
    'zls',
    'jsonls',
    'cucumber_language_server',
    'shopify_theme_ls',
    'ruff',
    'ocamllsp',
    'ols'
}


vim.lsp.enable(servers)
vim.lsp.config('*', {
    capabilities = capabilities,
    on_attach = require('quesnok.lsp.common').on_attach_client,
})

