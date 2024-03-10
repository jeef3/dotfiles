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
          ["<cr>"] = cmp.mapping.confirm({ select = true }),
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
    config = true,
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
    config = function()
      require("illuminate").configure({
        providers = { "lsp" },
        under_cursor = false,
      })
    end,
  },
}
