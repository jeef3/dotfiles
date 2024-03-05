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
    "hrsh7th/cmp-nvim-lsp"
  },

  opts = function()
    local cmp = require("cmp")

    return {
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
      }),
      mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<cr>"] = cmp.mapping.confirm({ select = true }),
      }),
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
