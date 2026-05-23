
local cwd = vim.uv.cwd()
local basename = vim.fs.basename(cwd)

local _99 = require("99")
_99.setup({
    provider = _99.Providers.ClaudeCodeProvider,  -- default: OpenCodeProvider
    logger = {
        level = _99.DEBUG,
        path = "/tmp/" .. basename .. ".99.debug",
        print_on_error = true,
    },
    tmp_dir = "./tmp",

    --- Completions: #rules and @files in the prompt buffer
    completion = {
        -- I am going to disable these until i understand the
        -- problem better.  Inside of cursor rules there is also
        -- application rules, which means i need to apply these
        -- differently
        -- cursor_rules = "<custom path to cursor rules>"

        --- A list of folders where you have your own SKILL.md
        --- Expected format:
        --- /path/to/dir/<skill_name>/SKILL.md
        ---
        --- Example:
        --- Input Path:
        --- "scratch/custom_rules/"
        ---
        --- Output Rules:
        --- {path = "scratch/custom_rules/vim/SKILL.md", name = "vim"},
        --- ... the other rules in that dir ...
        ---
        custom_rules = {
            "scratch/custom_rules/",
        },

        --- Configure @file completion (all fields optional, sensible defaults)
        files = {
            -- enabled = true,
            -- max_file_size = 102400,     -- bytes, skip files larger than this
            -- max_files = 5000,            -- cap on total discovered files
            -- exclude = { ".env", ".env.*", "node_modules", ".git", ... },
        },
        --- File Discovery:
        --- - In git repos: Uses `git ls-files` which automatically respects .gitignore
        --- - Non-git repos: Falls back to filesystem scanning with manual excludes
        --- - Both methods apply the configured `exclude` list on top of gitignore

        --- What autocomplete engine to use. Defaults to native (built-in) if not specified.
        source = "native", -- "native" (default), "cmp", or "blink"
    },
    md_files = {
        "AGENT.md",
    },
})

 -- KEYMAPS
vim.keymap.set("v", "<leader>9v", function()
    _99.visual()
end)

vim.keymap.set("v", "<leader>99", function()
    _99.visual({ additional_prompt = "Implement this. Match the surrounding code style. Do not add comments or unnecessary abstractions."})
end)

--- if you have a request you dont want to make any changes, just cancel it
vim.keymap.set("n", "<leader>9x", function()
    _99.stop_all_requests()
end)

vim.keymap.set("n", "<leader>9s", function()
    _99.search()
end)

vim.keymap.set("n", "<leader>9p", function()
  require("99.extensions.telescope").select_provider()
end)
vim.keymap.set("n", "<leader>9m", function()
  require("99.extensions.telescope").select_model()
end)
