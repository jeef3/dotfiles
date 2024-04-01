local icons = {
  Text = " ",
  Method = " ",
  Function = " ",
  Constructor = " ",
  Field = " ",
  Variable = " ",
  Class = " ",
  Interface = " ",
  Module = " ",
  Property = " ",
  Unit = " ",
  Value = " ",
  Enum = " ",
  Keyword = " ",
  Snippet = " ",
  Color = " ",
  File = " ",
  Reference = " ",
  Folder = " ",
  EnumMember = " ",
  Constant = " ",
  Struct = " ",
  Event = " ",
  Operator = " ",
  TypeParameter = " ",
}

return {
  ----------------
  -- CMP
  --
  -- A completion plugin for neovim coded in Lua.
  --
  -- https://github.com/hrsh7th/nvim-cmp
  ------------------
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",

      "onsails/lspkind.nvim",

      -- "ray-x/lsp_signature.nvim",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "windwp/nvim-autopairs",
    },

    opts = function()
      local cmp = require("cmp")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")

      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      return {
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        sources = cmp.config.sources({
          { name = "vsnip" },
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
        }),
        mapping = cmp.mapping.preset.insert({
          ["<C-j>"] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Insert,
          }),
          ["<C-k>"] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Insert,
          }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<cr>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
        }),
        window = {
          completion = {
            col_offset = -2,
            side_padding = 0,
          },
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          fields = { "kind", "abbr" },
          format = function(_, item)
            item.kind = " " .. icons[item.kind] or "" .. " "

            return item
          end,
        },
        experimental = {
          ghost_text = true,
        },
      }
    end,
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
      enable_check_bracket_line = true,
    },
  },

  ------------------
  -- Autotag
  --
  -- Use treesitter to auto close and auto rename html tag
  --
  -- https://github.com/windwp/nvim-ts-autotag
  ------------------
  { "windwp/nvim-ts-autotag", config = true },

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
        animation = function(s, n)
          return 0
        end,
        -- animation = function(s, n)
        --   return require("mini.indentscope").gen_animation.none(s, n)
        -- end,
      },
    },
    -- config = function(_, opts)
    --   local indentscope = require("mini.indentscope")

    --   indentscope.setup(opts)
    -- end
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
}
