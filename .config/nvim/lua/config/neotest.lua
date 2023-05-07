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
    running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
  },
})

vim.keymap.set("n", "<leader>ts", neotest.summary.open)
vim.keymap.set("n", "<leader>tNn", neotest.run.run)
vim.keymap.set("n", "<leader>tNN", function()
  neotest.run.run({ strategy = "dap" })
end)
