vim.lsp.config('shopify_theme_ls', {
    cmd = { "/usr/bin/shopify", "theme", "language-server" },
    root_dir = vim.lsp.util.root_pattern(".git", "config.yml"),
})
