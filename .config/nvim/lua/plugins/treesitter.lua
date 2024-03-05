----------------
-- Treesitter
--
-- https://github.com/
----------------

vim.opt.foldlevel = 20
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/playground",
  },
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },

  opts = {
    ensure_installed = "all",
    indent = {
      enable = true,
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  },
}
