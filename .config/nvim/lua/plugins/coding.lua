----------------
-- CMP
--
--https://github.com/hrsh7th/nvim-cmp
------------------

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
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",

    "onsails/lspkind.nvim",

    -- "ray-x/lsp_signature.nvim",
    "hrsh7th/cmp-nvim-lsp-signature-help",
  },

  opts = function()
    local cmp = require("cmp")

    return {
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
        end
      },
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      sources = cmp.config.sources({
        { name = "vsnip" },
        { name = "nvim_lsp" },
        { name = 'nvim_lsp_signature_help' }
      }),
      mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<cr>"] = cmp.mapping.confirm({ select = true }),
      }),
      window = {
        completion = {
          col_offset = -3,
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
}
