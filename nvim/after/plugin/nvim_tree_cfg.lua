local nvim_tree = require("nvim-tree")


-- Run a file in a bottom terminal split (minimal, no extra plugins)
local function open_term_prefill(cmd, cwd)
    vim.cmd("botright 12split")
    vim.cmd("terminal")
    local chan = vim.b.terminal_job_id

    if cwd and cwd ~= "" then
        vim.fn.chansend(chan, "cd " .. vim.fn.fnameescape(cwd) .. "\n")
    end

    -- Prefill only (no newline at the end)
    vim.fn.chansend(chan, cmd)
    vim.cmd("startinsert")
end

local function nvim_tree_prefill_run()
    local api = require("nvim-tree.api")
    local node = api.tree.get_node_under_cursor()
    if not node or node.type ~= "file" then
        vim.notify("Select a file.", vim.log.levels.WARN)
        return
    end

    local path = node.absolute_path or node.link_to or node.name
    if not path or path == "" then return end

    local dir = vim.fn.fnamemodify(path, ":h")
    local file = vim.fn.fnamemodify(path, ":t")

    -- If it’s executable, suggest running it
    if vim.fn.executable(path) == 1 then
        open_term_prefill("./" .. vim.fn.fnameescape(file), dir)
    else
        vim.notify("Not executable (chmod +x?)", vim.log.levels.WARN)
    end
end

local function on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set("n", "<leader>o", api.tree.toggle)
    vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
    vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))

    -- Add: R to run
    vim.keymap.set("n", "R", nvim_tree_prefill_run, {
        buffer = bufnr,
        silent = true,
        desc = "Open terminal + prefill ./binary",
    })


end




nvim_tree.setup {
    on_attach = on_attach,
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    filters = {
        -- hide specific directories/files
        custom = { ".git" },
    },
    renderer = {
        root_folder_modifier = ":t",
        -- These icons are visible when you install web-devicons
        icons = {
            glyphs = {
                default = "",
                symlink = "",
                folder = {
                    arrow_open = "",
                    arrow_closed = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "U",
                    deleted = "",
                    ignored = "◌",
                },
            },
        },
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    view = {
        width = 50,
        side = "left",
    },
}
