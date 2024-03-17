----------------
-- Princess
--
-- Princess 👸 theme, ported (with slight modifications) from tinacious design
--
-- https://github.com/tinacious/vscode-tinacious-design-syntax
-- https://github.com/jeef3/princess.nvim
------------------

return {
  -- "jeef3/princess.nvim",
  dir = "~/projects/princess.nvim",
  lazy = false,
  priority = 1000,
  dependencies = { "rktjmp/lush.nvim" },
  config = function()
    vim.cmd.colorscheme("princess_theme")
  end,
}
