----------------
-- Lua Line
--
-- https://github.com/nvim-lualine/lualine.nvim
----------------

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "chrisgrieser/nvim-recorder",
  },

  opts = {
    options = {
      theme = {
        normal = {
          a = "StatusLineNormalA",
          b = "StatusLineNormalB",
          c = "StatusLineNormalC",
        },
        inactive = {
          a = "StatusLineInactiveA",
          b = "StatusLineInactiveB",
          c = "StatusLineInactiveC",
        },
        insert = { a = "StatusLineInsert" },
        replace = { a = "StatusLineReplace" },
        command = { a = "StatusLineCommand" },
      },
      component_separators = "╲",
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { require("recorder").recordingStatus, "mode" },
      lualine_b = { "filename" },
      lualine_c = {
        -- require("auto-session.lib").current_session_name,
      },

      lualine_x = {},
      lualine_y = {
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = {
            error = " ",
            warn = " ",
            hint = " ",
            info = " ",
          },
        },
        {
          "diff",
          colored = true,
          symbols = {
            added = "",
            modified = "",
            removed = "",
            staged = "",
          },
        },
      },
      lualine_z = {
        "location",
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = { "filename" },
      lualine_c = {},

      lualine_x = {
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = {
            error = " ",
            warn = " ",
            hint = " ",
            info = " ",
          },
        },
        {
          "diff",
          colored = true,
          symbols = {
            added = "",
            modified = "",
            removed = "",
            staged = "",
          },
        },
      },
      lualine_y = { "location" },
      lualine_z = {},
    },
  },
}
