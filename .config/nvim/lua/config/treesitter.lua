----------------
-- Treesitter
--
-- https://github.com/
----------------

require("nvim-treesitter.configs").setup({
  ensure_installed = "all",
  indent = {
    enable = true,
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})
