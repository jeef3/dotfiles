--@class snacks.picker
--
local noop = function() end

return {
  ----------------
  -- Telescope
  --
  -- Find, Filter, Preview, Pick. All lua, all the time.
  --
  -- https://github.com/nvim-telescope/telescope.nvim
  ----------------
  {
    "nvim-telescope/telescope.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "rcarriga/nvim-notify",
      "olimorris/persisted.nvim",
      "debugloop/telescope-undo.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        -- enabled = vim.fn.executable("make") == 1,
      },
    },
    cmd = { "Telescope" },
    keys = {
      -- { "<c-t>" },
      { "<c-p>" },
      { "<c-s>" },
      { "gs", desc = "Find symbols in document" },
      { "gp", "<cmd>Telescope persisted<cr>", desc = "Switch session" },
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      local actions = require("telescope.actions")

      local p_window = require("telescope.pickers.window")

      require("telescope.pickers.layout_strategies").my_layout = function(
        self,
        max_columns
      )
        local initial_options = p_window.get_initial_window_options(self)
        local prompt = initial_options.prompt
        local results = initial_options.results
        local preview = initial_options.preview

        local top_pad = 2
        local width = math.min(64, max_columns - 12)

        local results_height = 10
        local preview_height = 15
        local preview_gap = 1

        local preview_start = top_pad + results_height + preview_gap + 7

        prompt.title = ""
        prompt.border = true
        prompt.borderchars = { " " }
        prompt.line = top_pad + 2
        prompt.width = width
        prompt.height = 1

        results.title = ""
        results.border = true
        results.borderchars = { " " }
        results.line = top_pad + 5
        results.width = width
        results.height = results_height

        preview.title = ""
        preview.border = true
        preview.borderchars = { " " }
        preview.line = preview_start
        preview.height = preview_height
        preview.width = math.min(86, max_columns)

        return {
          prompt = prompt,
          results = results,
          preview = self.previewer and preview.width > 0 and preview,
        }
      end

      telescope.setup({
        extensions = {
          persisted = { prompt_prefix = "  󰁯  " },
          undo = { prompt_prefix = "  󰕌 " },
        },
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<ScrollWheelDown>"] = actions.move_selection_next,
              ["<ScrollWheelUp>"] = actions.move_selection_previous,
              ["<ScrollWheelLeft>"] = noop,
              ["<ScrollWheelRight>"] = noop,
            },
          },
          preview = {
            filesize_limit = 0.5,
          },

          sorting_strategy = "ascending",
          layout_strategy = "my_layout",

          file_ignore_patterns = { "node_modules" },
          selection_caret = "  ",
        },
      })

      telescope.load_extension("notify")
      telescope.load_extension("persisted")
      telescope.load_extension("fzf")
      telescope.load_extension("undo")

      -- <C-t> Find files
      -- vim.keymap.set({ "n", "v" }, "<C-t>", function()
      --   builtin.find_files({
      --     find_command = {
      --       "fd",
      --       "--type",
      --       "f",
      --       "--hidden",
      --       "-E",
      --       ".git",
      --       "--strip-cwd-prefix",
      --     },
      --     prompt_prefix = "    ",
      --     previewer = false,
      --   })
      -- end)

      -- <C-p> Find in file
      -- vim.keymap.set({ "n", "v" }, "<C-p>", function()
      --   builtin.live_grep({
      --     vimgrep_arguments = {
      --       "rg",
      --       "--hidden",
      --       "--color=never",
      --       "--no-heading",
      --       "--with-filename",
      --       "--line-number",
      --       "--column",
      --       "--smart-case",
      --     },
      --     prompt_prefix = "    ",
      --   })
      -- end)

      -- <C-s> Find symbols
      vim.keymap.set({ "n", "v" }, "<C-s>", function()
        builtin.lsp_dynamic_workspace_symbols({
          prompt_prefix = "    ",
        })
      end)

      -- gs Find symbols
      vim.keymap.set({ "n", "v" }, "gs", function()
        builtin.lsp_document_symbols({
          prompt_prefix = "    ",
        })
      end)

      -- <C-y> Jump list
      vim.keymap.set({ "n", "v" }, "<C-y>", function()
        builtin.jumplist({
          prompt_prefix = "  󰆷  ",
        })
      end)
    end,
  },
}
