lua << EOF
local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
      }
    },
    dynamic_preview_title = true
  }
})

telescope.load_extension('fzf')

require 'illuminate'
require("scrollbar").setup()
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

local lspconfig = require("lspconfig")
-- local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
-- for type, icon in pairs(signs) do
--     local hl = "LspDiagnosticsSign" .. type
--     vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
-- end
-- vim.o.updatetime = 250
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = {
    prefix = ' ●',
  }
})

-- vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]]
-- vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]
--
-- local border = {
--       {"🭽", "FloatBorder"},
--       {"▔", "FloatBorder"},
--       {"🭾", "FloatBorder"},
--       {"▕", "FloatBorder"},
--       {"🭿", "FloatBorder"},
--       {"▁", "FloatBorder"},
--       {"🭼", "FloatBorder"},
--       {"▏", "FloatBorder"},
-- }
--
-- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
-- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
--   opts = opts or {}
--   opts.border = opts.border or border
--   return orig_util_open_floating_preview(contents, syntax, opts, ...)
-- end


-- require "lsp_signature".setup()
-- local coq = require("coq")
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
    }
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<CR>']  = cmp.mapping.complete()
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' }
  }),
  formatting = {
    fields = { "kind", "abbr" },
    format = function(_, vim_item)
      local str = cmp_kinds[vim_item.kind] or ""
      vim_item.kind = " " .. cmp_kinds[vim_item.kind] or "" .. " "

      return vim_item
    end,
  }
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local saga = require 'lspsaga'
saga.init_lsp_saga{
  error_sign = "",
  warn_sign = "",
  hint_sign = "",
  infor_sign = "",
  diagnostic_header_icon = "  ",

  code_action_icon = " ",
  code_action_keys = {
    quit = "<esc>",
  },

  rename_prompt_prefix = " ",
  rename_action_keys = {
    quit = "<esc>",
  },

  definition_preview_icon = "  ",

  border_style = "round",
}

local buf_map = function(bufnr, mode, lhs, rhs, opts)
  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
    silent = true,
  })
end

local setup_bindings = function(client, bufnr)
  vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
  vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
  vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
  vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")

  buf_map(bufnr, "n", "gd", ":LspDef<CR>")
  buf_map(bufnr, "n", "gr", ":LspRefs<CR>")
  buf_map(bufnr, "n", "K", ":Lspsaga hover_doc<CR>")
  buf_map(bufnr, "n", "[g", ":Lspsaga diagnostic_jump_prev<CR>")
  buf_map(bufnr, "n", "]g", ":Lspsaga diagnostic_jump_next<CR>")
  buf_map(bufnr, "n", "<leader>rn", ":Lspsaga rename<CR>")
  buf_map(bufnr, "n", "<leader>qf", ":Lspsaga code_action<CR>")
  buf_map(bufnr, "n", "<space>e", ":Lspsaga show_line_diagnostics<CR>")

  if client.resolved_capabilities.document_formatting then
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  end
end


lspconfig.tsserver.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    require 'illuminate'.on_attach(client)

    -- null-ls will take care of formatting
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    local ts_utils = require("nvim-lsp-ts-utils")
    ts_utils.setup({
      eslint_bin = "eslint_d",
      eslint_enable_diagnostics = true,
      eslint_enable_code_actions = true,
      enable_formatting = true,
      formatter = "prettierd",
    })

    ts_utils.setup_client(client)

    setup_bindings(client, bufnr)

  end,
})

lspconfig.ccls.setup({
  init_options = {
    compilationDatabaseDirectory = "build";

    index = {
      threads = 0;
    };

    clang = {
      excludeArgs = { "-frounding-math"} ;
    };
  }
})

lspconfig.pyright.setup({})

lspconfig.omnisharp.setup({
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    setup_bindings(client, bufnr)
  end,
  cmd = { "/Users/jeffknaggs/.local/share/nvim/lsp_servers/omnisharp/omnisharp/run", "--languageserver" , "--hostPID", tostring(pid) },
})

lspconfig.yamlls.setup({
  settings = {
    yaml = {
      schemas = {
        ["https://bitbucket.org/atlassianlabs/atlascode/raw/main/resources/schemas/pipelines-schema.json"] = "./bitbucket-pipelines.yml"
      }
    }
  }
})

local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.formatting.prettierd
  },
  on_attach = setup_bindings
})

require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  indent = {
    enable = true
  },
  highlight = {
    enable = true,
    disable = { "css" },
    additional_vim_regex_highlighting = false,
  }
}

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

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
require("neo-tree").setup({
  window = {
    width = 30
  },
  buffers = {
    show_unloaded = true
  },
  filesystem = {
    filtered_items = {
      visible = true,
      never_show = {
        ".DS_Store",
        "Session.vim"
      },
    },
    hijack_netrw_behavior = "disabled",
    follow_current_file = true
  }
})

require("neotest").setup({
  adapters = {
    require('neotest-vitest'),
  }
})
vim.cmd("command! NeoTestNearest lua require('neotest').run.run()")
vim.cmd("command! NeoTestFile lua require('neotest').run.run(vim.fn.expand('%'))")

require("coverage").setup()

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

EOF
