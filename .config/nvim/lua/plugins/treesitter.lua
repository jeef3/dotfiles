----------------
-- Treesitter
--
-- https://github.com/
----------------

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "VeryLazy" },
  dependencies = {
    "nvim-treesitter/playground",
  },
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  opts = {
    indent = { enable = true },
    highlight = { enable = true },
    ensure_installed = {
      "arduino",
      "bash",
      "c",
      "c_sharp",
      "cmake",
      "css",
      "csv",
      "diff",
      "dockerfile",
      "embedded_template",
      "git_config",
      "git_rebase",
      "gitattributes",
      "gitcommit",
      "gitignore",
      "go",
      "haskell",
      "html",
      "java",
      "javascript",
      "jq",
      "jsdoc",
      "json",
      "json5",
      "jsonc",
      "lua",
      "luadoc",
      "luap",
      "make",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "ruby",
      "rust",
      "scss",
      "swift",
      "tmux",
      "todotxt",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
    },
  },
  init = function(plugin)
    -- Apparently for performance
    require("lazy.core.loader").add_to_rtp(plugin)
    require("nvim-treesitter.query_predicates")
  end,

  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)

    vim.opt.foldlevel = 20
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  end,
}
