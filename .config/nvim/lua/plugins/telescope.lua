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
      "rcarriga/nvim-notify",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
        config = function()
          require("telescope").load_extension("fzf")
        end
      },
    },

    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      local themes = require("telescope.themes")
      local actions = require("telescope.actions")

      telescope.setup({
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
      })

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

      -- <C-p> Find in file
      vim.keymap.set({ "n", "v" }, "<C-p>", function()
        builtin.live_grep(themes.get_dropdown({
          prompt_prefix = "   ",
          selection_caret = "  ",
          prompt_title = "Find in files",
          winblend = 5,
        }))
      end)

      -- <C-s> Find symbols
      vim.keymap.set({ "n", "v" }, "<C-s>", function()
        builtin.lsp_dynamic_workspace_symbols({
          prompt_prefix = " ",
          selection_caret = "  ",
          prompt_title = "Symbols",
          winblend = 5,
          file_ignore_patterns = { "node_modules" },
        })
      end)

      -- <C-S> Find symbols
      vim.keymap.set({ "n", "v" }, "gs", function()
        builtin.lsp_document_symbols(themes.get_dropdown({
          prompt_prefix = " ",
          selection_caret = "  ",
          prompt_title = "Symbols",
          winblend = 5,
        }))
      end)

      -- <C-y> Jump list
      vim.keymap.set({ "n", "v" }, "<C-y>", function()
        builtin.jumplist({})
      end)
    end
  },
}
