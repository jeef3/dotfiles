return {
  ----------------
  -- Treesitter
  --
  -- https://github.com/
  ----------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "VeryLazy" },
    dependencies = {
      "RRethy/nvim-treesitter-endwise",
      "nvim-treesitter/playground",
    },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts = {
      indent = { enable = true },
      highlight = { enable = true },
      endwise = {
        enable = true,
      },
      ensure_installed = {
        "arduino",
        "bash",
        "c",
        "c_sharp",
        "cmake",
        "cpp",
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
    dependencies = {
      "nvim-treesitter/playground",
    },
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
