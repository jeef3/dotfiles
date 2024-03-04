----------------
-- CMP
--
--https://github.com/hrsh7th/nvim-cmp
------------------

local cmp = require("cmp")

require("lsp_signature").setup({
  bind = true,
  handler_opts = {
    border = "rounded",
  },
  toggle_key = "<M-x>",

  hint_enable = false,

  padding = " ",
  doc_lines = 0,
})

require("lspkind")
local cmp_kinds = {
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

cmp.setup({
  window = {
    completion = {
      col_offset = -3,
      side_padding = 0,
    },
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    -- ['<space>'] = cmp.mapping.complete(),
    ["<cr>"] = cmp.mapping.confirm({ select = true }),
  }),
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "vsnip" },
  }),
  formatting = {
    fields = { "kind", "abbr" },
    format = function(_, vim_item)
      local str = cmp_kinds[vim_item.kind] or ""
      vim_item.kind = " " .. cmp_kinds[vim_item.kind] or "" .. " "

      return vim_item
    end,
  },
  experimental = {
    ghost_text = true,
  },
})
