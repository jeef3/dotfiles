----------------
-- Telescope
--
-- https://github.com/nvim-telescope/telescope.nvim
----------------

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
        after = function()
          require("telescope").load_extension("fzf")
        end
      },
      "rcarriga/nvim-notify",
    },

    opts = function()
      local actions = require("telescope.actions")

      return {
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<c-j>"] = actions.move_selection_next,
              ["<c-k>"] = actions.move_selection_previous,
            },
          },
          dynamic_preview_title = true,
        },
      }
    end,

    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      local themes = require("telescope.themes")

      telescope.load_extension("notify")

      -- <C-t> Find files
      vim.keymap.set({ "n", "v" }, "<C-t>", function()
        builtin.find_files(themes.get_dropdown({
          find_command = { "fd", "--type", "f", "--hidden", "--strip-cwd-prefix" },
          prompt_prefix = "   ",
          selection_caret = "  ",
          prompt_title = "",
          previewer = false,
          winblend = 5,
        }))
      end)
    end
  },
}
