----------------
-- Princess
--
-- Princess 👸 theme, ported (with slight modifications) from tinacious design
--
-- https://github.com/tinacious/vscode-tinacious-design-syntax
------------------

return {
  dir = vim.fn.stdpath("config"),
  name = "princess-theme",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("princess")
  end,
}
