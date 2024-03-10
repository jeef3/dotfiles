----------------
-- Neotest
--
-- https://github.com/nvim-neotest/neotest
----------------

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",

      -- Runners
      "nvim-treesitter/nvim-treesitter",
      "marilari88/neotest-vitest",
      "thenbe/neotest-playwright",
    },
    config = function()
      local neotest = require("neotest")
      neotest.setup({
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
      })

      vim.keymap.set("n", "<leader>to", neotest.summary.toggle)
      vim.keymap.set("n", "<leader>tc", neotest.output_panel.toggle)

      vim.keymap.set("n", "<leader>tn", neotest.run.run)
      vim.keymap.set("n", "<leader>tN", function()
        neotest.run.run({ strategy = "dap" })
      end)
    end,
  },

  -- Code Coverage
  {
    "andythigpen/nvim-coverage",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}
