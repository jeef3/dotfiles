require('nvim-treesitter.configs').setup {
  ensure_installed = "all",
  indent = {
    enable = true
  },
  highlight = {
    enable = true,
    --disable = { "css" },
    additional_vim_regex_highlighting = false,
  }
}
