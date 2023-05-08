----------------
-- Neotest
--
-- https://github.com/nvim-neotest/neotest
----------------

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

vim.keymap.set("n", "<leader>ts", neotest.summary.toggle)

vim.keymap.set("n", "<leader>tn", neotest.run.run)
vim.keymap.set("n", "<leader>tN", function()
  neotest.run.run({ strategy = "dap" })
end)
