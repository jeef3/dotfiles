return {
  ----------------
  -- Dad Bod
  --
  -- dadbod.vim: Modern database interface for Vim
  -- https://github.com/tpope/vim-dadbod
  --
  -- https://github.com/kristijanhusak/vim-dadbod-ui
  ----------------
  {

    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      {
        "kristijanhusak/vim-dadbod-completion",
        ft = { "sql", "mysql", "plsql" },
        lazy = true,
      },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
}
