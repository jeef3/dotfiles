return {
  ----------------
  -- Neotest
  --
  -- https://github.com/nvim-neotest/neotest
  ----------------
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",

      -- Runners
      "marilari88/neotest-vitest",
      "thenbe/neotest-playwright",
    },
    keys = {
      {
        "<leader>tn",
        "<cmd>lua require('neotest').run.run()<CR>",
        desc = "Run tests",
      },
      {
        "<leader>tN",
        "<cmd>lua require('neotest').run.run({ strategy = 'dap' })<CR>",
        desc = "Debug tests",
      },
      {
        "<leader>to",
        "<cmd>lua require('neotest').summary.toggle()<CR>",
        desc = "Toggle summary",
      },
      {
        "<leader>tc",
        "<cmd>lua require('neotest').output_panel.toggle()<CR>",
        desc = "Toggle output panel",
      },
    },
    opts = {
      adapters = {
        require("neotest-vitest"),
        require("neotest-playwright").adapter(),
      },
      icons = {
        failed = "󰅚",
        passed = "󰗡",
        running_animated = {
          "⠋",
          "⠙",
          "⠹",
          "⠸",
          "⠼",
          "⠴",
          "⠦",
          "⠧",
          "⠇",
          "⠏",
        },
      },
      quickfix = { enabled = false },
    },
  },

  -- Code Coverage
  {
    "andythigpen/nvim-coverage",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}
