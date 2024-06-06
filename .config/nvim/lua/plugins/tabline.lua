----------------
-- Tab Line
--
-- Tabline for neovim written in lua
--
-- https://github.com/seblj/nvim-tabline
----------------

return {
  "seblj/nvim-tabline",
  dependencies = "nvim-tree/nvim-web-devicons",

  opts = {
    padding = 1,
    always_show_tabs = true,
    close_icon = "×",
    separator = "▎",
  },
}
