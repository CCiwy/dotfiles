-- Common on_attach function for all LSPs
local module = {}


function module.on_attach_client(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "gD", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "ge", function() vim.diagnostic.jump({count= 1}) end, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end


function module.extend_on_attach(extra)
    if not extra then
        return module.on_attach_client
    end
    return function(client, bufnr)
        module.on_attach_client(client, bufnr)
        extra(client, bufnr)
    end
end

return module
