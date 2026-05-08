--------------------------------
-- Coding
--
-- Plugins that alter the coding environment in a more general way. LSP config
-- stored separately.
--------------------------------

return {
  ----------------
  -- Blink.cmp
  --
  -- Performant, batteries-included completion plugin for Neovim
  --
  -- https://github.com/saghen/blink.cmp
  ------------------
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "giuxtaposition/blink-cmp-copilot",
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-x><C-o>"] = { "show", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
      },

      cmdline = {
        keymap = {
          ["<C-j>"] = { "select_next", "fallback" },
          ["<C-k>"] = { "select_prev", "fallback" },
        },
        completion = {
          menu = {
            auto_show = function()
              return vim.fn.getcmdtype() == ":"
            end,
          },
          list = {
            selection = { preselect = false, auto_insert = true },
          },
        },
      },

      appearance = {
        nerd_font_variant = "normal",
      },

      completion = {
        documentation = { auto_show = true },
        ghost_text = { enabled = true },
      },

      signature = { enabled = true },

      sources = {
        default = { "lsp", "path", "snippets", "buffer", "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            score_offset = 100,
            async = true,
            transform_items = function(_, items)
              local CompletionItemKind =
                require("blink.cmp.types").CompletionItemKind
              local kind_idx = #CompletionItemKind + 1
              CompletionItemKind[kind_idx] = "Copilot"
              for _, item in ipairs(items) do
                item.kind = kind_idx
              end
              return items
            end,
          },
        },
      },

      fuzzy = { implementation = "prefer_rust" },
    },
  },

  ------------------
  -- Autopairs
  --
  -- Autopairs for neovim written in lua
  --
  -- https://github.com/windwp/nvim-autopairs
  ------------------
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
    },
  },

  ------------------
  -- Autotag
  --
  -- Use treesitter to auto close and auto rename html tag
  --
  -- https://github.com/windwp/nvim-ts-autotag
  ------------------
  { "windwp/nvim-ts-autotag", config = true, enabled = false },

  ------------------
  -- Mini.Indentscope
  --
  -- Neovim Lua plugin to visualize and operate on indent scope. Part of
  -- 'mini.nvim' library.
  --
  -- https://github.com/echasnovski/mini.indentscope
  ------------------
  {
    "echasnovski/mini.indentscope",
    version = false,
    opts = {
      symbol = "┊",
      draw = {
        delay = 0,
        animation = function(_, _)
          return 0
        end,
      },
    },
  },

  ------------------
  -- Highlight other uses of a word
  --
  -- (Neo)Vim plugin for automatically highlighting other uses of the word under
  -- the cursor using either LSP, Tree-sitter, or regex matching.
  --
  -- https://github.com/RRethy/vim-illuminate
  ------------------
  {
    "RRethy/vim-illuminate",
    opts = {
      providers = { "lsp", "treesitter" },
      under_cursor = false,
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },

  ------------------
  -- TODO Comments
  --
  -- ✅ Highlight, list and search todo comments in your projects
  --
  -- https://github.com/folke/todo-comments.nvim
  ------------------
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      highlight = {
        multiline = false,
      },
      keywords = {
        PERF = { color = "perf" },
      },
      colors = { perf = { "Constant" } },
    },
  },

  ------------------
  -- ts-comments
  --
  -- Tiny plugin to enhance Neovim's native comments
  --
  -- https://github.com/folke/ts-comments.nvim
  ------------------
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
  },

  ------------------
  -- Overseer
  --
  -- A task runner and job management plugin for Neovim
  --
  -- https://github.com/stevearc/overseer.nvim
  ------------------
  {
    "stevearc/overseer.nvim",
    dependencies = {
      "rcarriga/nvim-notify",
      "stevearc/dressing.nvim",
    },
    opts = {
      templates = { "builtin", "user.eslint_build", "user.tsc" },
    },
    init = function()
      local overseer = require("overseer")

      vim.api.nvim_create_user_command("OverseerRestartLast", function()
        local tasks = overseer.list_tasks({ recent_first = true })

        if vim.tbl_isempty(tasks) then
          vim.notify("No tasks found", vim.log.levels.WARN)
        else
          overseer.run_action(tasks[1], "restart")
        end
      end, {})
    end,
  },

  ------------------
  -- Dropbar
  --
  -- IDE-like breadcrumbs, out of the box
  --
  -- https://github.com/Bekaboo/dropbar.nvim
  ------------------
  {
    "Bekaboo/dropbar.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    opts = {
      bar = {
        enable = function(buf, win)
          if
            not vim.api.nvim_buf_is_valid(buf)
            or not vim.api.nvim_win_is_valid(win)
            or vim.fn.win_gettype(win) ~= ""
            or vim.wo[win].winbar ~= ""
            or vim.bo[buf].ft == "help"
          then
            return false
          end

          if vim.bo[buf].ft == "copilot-chat" then
            return false
          end

          local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(buf))
          if stat and stat.size > 1024 * 1024 then
            return false
          end

          return vim.bo[buf].bt == "terminal"
            or vim.bo[buf].ft == "markdown"
            or pcall(vim.treesitter.get_parser, buf)
            or not vim.tbl_isempty(vim.lsp.get_clients({
              bufnr = buf,
              method = vim.lsp.protocol.Methods.textDocument_documentSymbol,
            }))
        end,
      },
    },
  },

  ------------------
  -- Convert
  --
  -- A Neovim plugin to help with css unit, and number conversions.
  --
  -- https://github.com/cjodo/convert.nvim
  ------------------
  {
    "cjodo/convert.nvim",
    enabled = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    keys = {
      {
        "<leader>cn",
        "<cmd>ConvertFindNext<CR>",
        desc = "Find next convertable unit",
      },
      {
        "<leader>cc",
        "<cmd>ConvertFindCurrent<CR>",
        desc = "Find convertable unit in current line",
      },
      -- Add "v" to enable converting a selected region
      {
        "<leader>ca",
        "<cmd>ConvertAll<CR>",
        mode = { "n", "v" },
        desc = "Convert all of a specified unit",
      },
    },
  },
}
