----------------
-- Neotest
--
-- https://github.com/nvim-neotest/neotest
----------------

require("neotest").setup({
  adapters = {
    require("neotest-vitest"),
    require("neotest-playwright").adapter(),
  },
})
