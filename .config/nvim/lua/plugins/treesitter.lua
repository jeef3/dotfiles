local tools = require("config.tools")

return {
  ----------------
  -- Treesitter
  --
  -- Parser installer and query provider for tree-sitter languages.
  -- Highlighting, folding, and indentation are now native Neovim features.
  --
  -- https://github.com/nvim-treesitter/nvim-treesitter
  ----------------
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install(tools.treesitter_syntaxes)

      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
  {
    "bezhermoso/tree-sitter-ghostty",
    build = "make nvim_install",
  },

  ----------------
  -- Rainbow delimiters
  --
  -- Rainbow delimiters for Neovim with Tree-sitter
  --
  -- https://github.com/hiphish/rainbow-delimiters.nvim
  ----------------
  {
    "HiPhish/rainbow-delimiters.nvim",
    opts = {
      highlight = {
        "RainbowDelimiterYellow",
        "RainbowDelimiterPurple",
        "RainbowDelimiterBlue",
      },
    },
    config = function(_, opts)
      require("rainbow-delimiters.setup").setup(opts)
    end,
  },
}
