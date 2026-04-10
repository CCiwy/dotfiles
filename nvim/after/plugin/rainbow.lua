-- rainbow-delimiters uses Tree-sitter, so it assumes TS is working.
local ok, rainbow_delimiters = pcall(require, "rainbow-delimiters")
if not ok then
    return
end

vim.g.rainbow_delimiters = {
    strategy = {
        [""] = rainbow_delimiters.strategy["global"],
        vim = rainbow_delimiters.strategy["local"],
    },
    query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks", -- optional; some people prefer this for lua
        javascript = "rainbow-parens",
        typescript = "rainbow-parens",
        tsx = "rainbow-parens",
    },
    highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
    },
}
