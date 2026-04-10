local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
  return
end

configs.setup({
  ensure_installed = {
    "c", "lua", "rust", "python", "javascript",
    "typescript", "html", "graphql", "json", "odin"
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = {},
  },
})
