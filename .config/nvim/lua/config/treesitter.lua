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

vim.opt.foldlevel = 20
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
