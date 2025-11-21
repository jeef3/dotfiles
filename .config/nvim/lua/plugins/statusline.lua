----------------
-- Lua Line
--
-- https://github.com/nvim-lualine/lualine.nvim
----------------

local function show_macro_recording()
  local reg = vim.fn.reg_recording()
  if reg == "" then
    return ""
  end

  return "  [" .. reg .. "]"
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {},

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
      component_separators = "",
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { { "macro-recording", fmt = show_macro_recording }, "mode" },
      lualine_b = {
        require("codeowners").codeowners,
        {
          "filename",
          path = 0,

          on_click = function()
            local filepath = vim.api.nvim_buf_get_name(0)
            local relpath = vim.fn.fnamemodify(filepath, ":.")
            vim.notify(relpath, vim.log.levels.INFO)
          end,
        },
      },
      lualine_c = {
        -- require("auto-session.lib").current_session_name,
      },

      lualine_x = { {
        "lsp_status",
        separator = "•",
      } },
      lualine_y = {
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = {
            error = "󰅚 ",
            warn = "󰀪 ",
            info = "󰋽 ",
            hint = "󰌶 ",
          },
        },
        {
          "diff",
          colored = true,
          symbols = {
            added = " ",
            modified = " ",
            removed = " ",
            staged = " ",
          },
        },
      },
      lualine_z = {
        "location",
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = { { "filename", path = 1 } },
      lualine_c = {},

      lualine_x = {
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = {
            error = "󰅚 ",
            warn = "󰀪 ",
            info = "󰋽 ",
            hint = "󰌶 ",
          },
        },
        {
          "diff",
          colored = true,
          symbols = {
            added = " ",
            modified = " ",
            removed = " ",
            staged = " ",
          },
        },
      },
      lualine_y = { "location" },
    },
    -- tabline = {
    --   lualine_b = { { "tabs", mode = 1 } },
    --   lualine_y = { "branch" },
    -- },
  },

  init = function()
    local lualine = require("lualine")

    vim.api.nvim_create_autocmd("RecordingEnter", {
      callback = function()
        local reg = vim.fn.reg_recording()

        vim.notify(
          "Macro recording started [" .. reg .. "]",
          vim.log.levels.INFO,
          { title = "Macro Recording Started" }
        )

        lualine.refresh({ place = { "statusline" } })
      end,
    })

    vim.api.nvim_create_autocmd("RecordingLeave", {
      callback = function()
        local reg = vim.fn.reg_recording()
        local recorded = vim.fn.keytrans(
          vim.api.nvim_replace_termcodes(
            vim.fn.keytrans(vim.fn.getreg(reg)),
            true,
            true,
            true
          )
        )

        vim.notify(
          "Macro recording stopped [" .. reg .. "]\n" .. recorded,
          vim.log.levels.INFO,
          { title = "Macro Recording Stopped" }
        )

        vim.loop.new_timer():start(
          50,
          0,
          vim.schedule_wrap(function()
            lualine.refresh({ place = { "statusline" } })
          end)
        )
      end,
    })
  end,
}
