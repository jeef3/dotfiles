----------------
-- LSP Config
--
-- https://github.com/neovim/nvim-lspconfig
----------------

local lspconfig = require("lspconfig")
local lspsaga = require("lspsaga")
local null_ls = require("null-ls")
local cmp = require("cmp_nvim_lsp")

lspsaga.setup({
  code_action_keys = {
    quit = "<esc>",
  },

  winblend = 5,

  diagnostic_header = { " ", " ", " ", " ﴞ" },
})

-- Configure and set up highlight groups for custom LSP signs
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.cmd([[
  sign define DiagnosticSignError texthl=DiagnosticSignError numhl=DiagnosticLineNrError
  sign define DiagnosticSignWarn  texthl=DiagnosticSignWarn  numhl=DiagnosticLineNrWarn
  sign define DiagnosticSignInfo  texthl=DiagnosticSignInfo  numhl=DiagnosticLineNrInfo
  sign define DiagnosticSignHint  texthl=DiagnosticSignHint  numhl=DiagnosticLineNrHint
]])

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = {
    prefix = " ●",
  },
})

-- Custom border styles
-- local border = {
--   {'🭽', 'FloatBorder'},
--   {'▔', 'FloatBorder'},
--   {'🭾', 'FloatBorder'},
--   {'▕', 'FloatBorder'},
--   {'🭿', 'FloatBorder'},
--   {'▁', 'FloatBorder'},
--   {'🭼', 'FloatBorder'},
--   {'▏', 'FloatBorder'},
-- }

-- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
-- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
--   opts = opts or {}
--   opts.border = opts.border or border
--   return orig_util_open_floating_preview(contents, syntax, opts, ...)
-- end

local capabilities = cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  -- vim.keymap.set('n', 'K',  vim.lsp.buf.hover, bufopts)

  -- Lspsaga overrides
  vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", bufopts)
  vim.keymap.set("n", "[g", "<cmd>Lspsaga diagnostic_jump_prev<CR>", bufopts)
  vim.keymap.set("n", "]g", "<cmd>Lspsaga diagnostic_jump_next<CR>", bufopts)
  vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", bufopts)
  vim.keymap.set("n", "<leader>qf", "<cmd>Lspsaga code_action<CR>", bufopts)
  vim.keymap.set("n", "<space>e", "<cmd>Lspsaga show_line_diagnostics<CR>", bufopts)

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end

null_ls.setup({
  debug = true,
  sources = {
    null_ls.builtins.diagnostics.eslint_d,
    -- null_ls.builtins.diagnostics.luacheck,
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.astyle,
    null_ls.builtins.formatting.stylua,
  },
  on_attach = on_attach,
})

----------------
-- Languages
----------------

lspconfig.tsserver.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.ccls.setup({
  init_options = {
    compilationDatabaseDirectory = "build",

    index = {
      threads = 0,
    },

    clang = {
      excludeArgs = { "-frounding-math" },
    },
  },
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.sourcekit.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.omnisharp.setup({
  cmd = {
    "/Users/jeffknaggs/.local/share/nvim/lsp_servers/omnisharp/omnisharp/run",
    "--languageserver",
    "--hostPID",
    tostring(pid),
  },
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.yamlls.setup({
  settings = {
    yaml = {
      schemas = {
        ["https://bitbucket.org/atlassianlabs/atlascode/raw/main/resources/schemas/pipelines-schema.json"] = "./bitbucket-pipelines.yml",
        ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.0/schema.yaml"] = "./schema.yml",
      },
    },
  },
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.sumneko_lua.setup({
  capabilities = capabilities,
  on_attach = on_attach,

  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
