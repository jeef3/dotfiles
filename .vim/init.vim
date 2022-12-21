lua << EOF
--require 'illuminate'
--require("scrollbar").setup()

require 'zen-mode'.setup({
  window = {
    width = 90
  },
  plugins = {
    tmux = { enabled = true },
    kitty = {
      enabled = true,
      font = "+4",
    },
  }
})

require("mason").setup()

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = {
    prefix = ' ●',
  }
})

vim.cmd [[
  sign define DiagnosticSignError texthl=DiagnosticSignError numhl=DiagnosticLineNrError
  sign define DiagnosticSignWarn  texthl=DiagnosticSignWarn  numhl=DiagnosticLineNrWarn
  sign define DiagnosticSignInfo  texthl=DiagnosticSignInfo  numhl=DiagnosticLineNrInfo
  sign define DiagnosticSignHint  texthl=DiagnosticSignHint  numhl=DiagnosticLineNrHint
]]

-- vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]]
-- vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

local border = {
  {"🭽", "FloatBorder"},
  {"▔", "FloatBorder"},
  {"🭾", "FloatBorder"},
  {"▕", "FloatBorder"},
  {"🭿", "FloatBorder"},
  {"▁", "FloatBorder"},
  {"🭼", "FloatBorder"},
  {"▏", "FloatBorder"},
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- require "lsp_signature".setup()
local cmp = require('cmp')
local lspkind = require('lspkind')
local cmp_kinds = {
  Text = ' ',
  Method = ' ',
  Function = ' ',
  Constructor = ' ',
  Field = ' ',
  Variable = ' ',
  Class = ' ',
  Interface = ' ',
  Module = ' ',
  Property = ' ',
  Unit = ' ',
  Value = ' ',
  Enum = ' ',
  Keyword = ' ',
  Snippet = ' ',
  Color = ' ',
  File = ' ',
  Reference = ' ',
  Folder = ' ',
  EnumMember = ' ',
  Constant = ' ',
  Struct = ' ',
  Event = ' ',
  Operator = ' ',
  TypeParameter = ' ',
}

cmp.setup({
  window = {
    completion = {
      col_offset = -3,
      side_padding = 0,
    },
    documentation = cmp.config.window.bordered()
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    -- ['<space>'] = cmp.mapping.complete(),
    ['<C-Space>']  = cmp.mapping.confirm({ select = true })
  }),
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'vsnip' },
    -- { name = 'path' },
    -- { name = 'cmdline' },
    -- { name = 'buffer' },
    -- { name = 'nvim_lua' },
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
    ghost_text = true
  }
})



require'colorizer'.setup()

require("trouble").setup({})

require('tabline').setup({
  padding = 1,
  always_show_tabs = true,
  close_icon = '×',
  separator = '▎'
})

require'lualine'.setup({
  options = {
    theme = {
      normal = {
        a = "StatusLineNormalA",
        b = "StatusLineNormalB",
        c = "StatusLineNormalC",
      },
      insert = { a = "StatusLineInsert" },
      replace = { a = "StatusLineReplace" },
      command = { a = "StatusLineCommand" },
    },
    component_separators = '╲',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'filename' },
    lualine_c = {  },

    lualine_x = { },
    lualine_y = {
      {
        'diagnostics',
        sources = {'nvim_diagnostic'},
        symbols = { error = " ", warn = " ", hint = " ", info = " " },
      },
      {
        'diff',
        colored = true,
        symbols = { added = '+', modified = '~', removed = '-' },
      }
    },
    lualine_z = {'location'},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {'filename'},
    lualine_c = {},

    lualine_x = {
      {
        'diagnostics',
        sources = {'nvim_diagnostic'},
        symbols = { error = " ", warn = " ", hint = " ", info = " " },
      },
      {
        'diff',
        colored = true,
        symbols = { added = '+', modified = '~', removed = '-' },
      }
    },
    lualine_y = { 'location' },
    lualine_z = {},
  }
})

require'gitsigns'.setup({
  signs = {
    add       = { text = "▎" },
    change    = { text = "▎" },
    delete    = { text = "▎" },
  },

  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
})

-- vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
-- require("neo-tree").setup({
--   window = {
--     width = 30
--   },
--   buffers = {
--     show_unloaded = true
--   },
--   filesystem = {
--     filtered_items = {
--       visible = true,
--       never_show = {
--         ".DS_Store",
--         "Session.vim"
--       },
--     },
--     hijack_netrw_behavior = "disabled",
--     follow_current_file = true
--   }
-- })

-- require("neotest").setup({
--   adapters = {
--     require('neotest-vitest'),
--     --require("neotest-vim-test"),
--   }
-- })
-- vim.cmd("command! NeoTestNearest lua require('neotest').run.run()")
-- vim.cmd("command! NeoTestFile lua require('neotest').run.run(vim.fn.expand('%'))")

-- require("coverage").setup()

local dap = require("dap")
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/.vim/vscode-node-debug2/out/src/nodeDebug.js'},
}
dap.configurations.javascript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
  },
}

dap.adapters.firefox = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/.vim/vscode-firefox-debug/dist/adapter.bundle.js'},
}
dap.configurations.typescript = {
  name = 'Debug with Firefox',
  type = 'firefox',
  request = 'launch',
  reAttach = true,
  url = 'http://localhost:3000',
  webRoot = '${workspaceFolder}',
  firefoxExecutable = '/usr/bin/firefox'
}

local dapui = require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

require('cinnamon').setup({
  default_delay = 4,
})

require("diffview").setup({
  enhanced_diff_hl = true,
  signs = {
    fold_closed = "",
    fold_open = "",
    done = "✓",
  },
  hooks = {
    view_enter = function(view)
      vim.cmd [[:Gitsigns toggle_numhl true]]
    end,
    view_leave = function(view)
      vim.cmd [[:Gitsigns toggle_numhl false]]
    end,
  },
})

require("nvim-autopairs").setup()
require('nvim-ts-autotag').setup()

require("i")
EOF
