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
      "nvim-neotest/neotest-jest",
      "marilari88/neotest-vitest",
      "thenbe/neotest-playwright",
      "Issafalcon/neotest-dotnet",
      "fredrikaverpil/neotest-golang",
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
    config = function()
      require("neotest").setup({
        discovery = { enabled = false },
        adapters = {
          require("neotest-jest")({
            jestCommand = require("neotest-jest.jest-util").getJestCommand(
              vim.fn.expand("%:p:h")
            ),
          }),
          require("neotest-vitest"),
          require("neotest-playwright").adapter({
            options = {
              enable_dynamic_test_discovery = true,
            },
          }),

          require("neotest-dotnet")({}),
          require("neotest-golang")({}),
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
      })
    end,
  },

  ----------------
  -- Code Coverage
  --
  -- Displays test coverage data in the sign column
  --
  -- https://github.com/andythigpen/nvim-coverage
  ----------------
  {
    "andythigpen/nvim-coverage",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "Coverage" },
    config = true,
  },
}
