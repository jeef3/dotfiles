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
      },
      nes = { enabled = false },
      panel = { enabled = false },
    },
  },
}
