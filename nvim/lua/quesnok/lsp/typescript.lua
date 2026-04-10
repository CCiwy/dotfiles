local common = require('quesnok.lsp.common')

require("typescript-tools").setup({
    on_attach = common.extend_on_attach(function(client, _)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end),
    settings = {
        tsserver_max_memory = 4096,
        tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeInlayVariableTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
        },
    },
})

local util = require("lspconfig.util")
vim.lsp.config('eslint', {
    root_dir = util.root_pattern(
        ".eslintrc",
        ".eslintrc.mjs",
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.json"
    ),
    cmd = { "vscode-eslint-language-server", "--stdio" },
    settings = {
        eslint = {
            validate = "on",
            format = true,
            run = "onSave",
            workingDirectory = { mode = "location" },
            nodePath = "node_modules",
            experimental = { useFlatConfig = true }
        },
        validate = "on",
        format = true,
        run = "onSave",
        workingDirectory = { mode = "location" },
        nodePath = "node_modules",
        experimental = { useFlatConfig = true }
    },
    on_attach = common.extend_on_attach(function(_, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = false,
                    filter = function(srv) return srv.name == "eslint" end,
                })
            end,
        })
    end),
})

local function eslint_node_path(client)
    local root = client.root_dir or ""
    if root:match("/frontend$") then
        return "node_modules"
    end
    return "frontend/node_modules"
end


-- ESLint.nvim helpers for formatting/code actions
require("eslint").setup({
    bin = 'eslint', -- or `eslint_d`
    code_actions = {
        enable = true,
        apply_on_save = {
            enable = true,
            types = { "directive", "problem", "suggestion", "layout" },
        },
        disable_rule_comment = {
            enable = true,
            location = "separate_line", -- or `same_line`
        },
    },
    diagnostics = {
        enable = true,
        report_unused_disable_directives = false,
        run_on = "type", -- or `save`
    },
})

-- CYPRESS
vim.lsp.config('cucumber_language_server', {
    settings = {
        cucumber = {
            features = { "**/cypress/e2e/**/*.feature" },
            glue = { "**/cypress/e2e/**/*.ts", "**/step_definitions/**/*.ts" },
        },
    }
})


