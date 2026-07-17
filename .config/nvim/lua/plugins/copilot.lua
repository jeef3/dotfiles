---@module "lazy"

return {
  ----------------
  -- copilot.lua
  --
  -- Fully featured & enhanced replacement for copilot.vim complete with API for
  -- interacting with Github Copilot
  --
  -- https://github.com/zbirenbaum/copilot.lua
  ------------------
  ---@module "copilot"
  ---@type LazyPluginSpec
  {
    "zbirenbaum/copilot.lua",
    dependencies = {
      "copilotlsp-nvim/copilot-lsp",
    },
    cmd = "Copilot",
    event = "InsertEnter",

    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = false,
        keymap = {
          accept = "<C-l>",
        },
      },
      nes = { enabled = false },
      panel = { enabled = false },
    },
  },

  ----------------
  -- CopilotChat.nvim
  --
  -- Chat with GitHub Copilot in Neovim  --
  --
  -- https://github.com/CopilotC-Nvim/CopilotChat.nvim
  ------------------
  ---@module "CopilotChat"
  ---@type LazyPluginSpec
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "make tiktoken",

    ---@type CopilotChat.config.Config
    opts = {
      model = "auto",
      window = {
        layout = "float",
        title = "   Copilot ",
        title_pos = "center",
        border = {
          "🬕",
          "🬂",
          "🬨",
          "▐",
          "🬷",
          "🬭",
          "🬲",
          "▌",
        },
        zindex = 100,
      },

      -- headers = {
      --   user = "👤 You",
      --   assistant = "🤖 Copilot",
      --   tool = "🔧 Tool",
      -- },

      -- separator = "━━",
      -- auto_fold = true, -- Automatically folds non-assistant messages
    },
  },
}
