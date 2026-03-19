vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "copilot-*",
  callback = function()
    -- Set buffer-local options
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.opt_local.conceallevel = 0
  end,
})
--
-- -- Quick chat keybinding
-- vim.keymap.set({ "n", "v" }, "<leader>cq", function()
--   local input = vim.fn.input("Quick Chat: ")
--   if input ~= "" then
--     require("CopilotChat").ask(input, {
--       selection = require("CopilotChat.select").buffer,
--     })
--   end
-- end, { desc = "CopilotChat - Quick chat" })

return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      {
        "github/copilot.vim",
        { "nvim-lua/plenary.nvim", branch = "master" },
      },
    },
    build = "make tiktoken",

    --- @module "CopilotChat"
    --- @type CopilotChat.config.Config
    opts = {
      headers = {
        user = " Me",
        assistant = "  Copilot",
        tool = "󱁤 Tool",
      },

      window = {
        width = 60,
        title = "🤖 AI Assistant",
      },

      separator = "-",
      auto_fold = true,
    },
  },
}
