----------------
-- LSP Config
--
-- https://github.com/neovim/nvim-lspconfig
----------------

local lspconfig = require('lspconfig')
local null_ls = require('null-ls')

require('lspsaga').init_lsp_saga{
  code_action_keys = {
    quit = "<esc>",
  },

  saga_winblend = 5,
  diagnostic_header = { " ", " ", " ", " ﴞ" },
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == "null-ls"
    end,
    bufnr = bufnr
  })
end

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.formatting.prettierd
  },
})

local capabilities = require('cmp_nvim_lsp')
  .default_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  -- vim.keymap.set('n', 'K',  vim.lsp.buf.hover, bufopts)

  -- Lspsaga overrides
  vim.keymap.set('n', 'K',  '<cmd>Lspsaga hover_doc<CR>', bufopts)
  vim.keymap.set('n', '[g', '<cmd>Lspsaga diagnostic_jump_prev<CR>', bufopts)
  vim.keymap.set('n', ']g', '<cmd>Lspsaga diagnostic_jump_next<CR>', bufopts)
  vim.keymap.set('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', bufopts)
  vim.keymap.set('n', '<leader>qf', '<cmd>Lspsaga code_action<CR>', bufopts)
  vim.keymap.set('n', '<space>e', '<cmd>Lspsaga show_line_diagnostics<CR>', bufopts)

  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end
end

----------------
-- Languages
----------------

lspconfig.tsserver.setup({
  capabilities = capabilities,
  on_attach = on_attach,
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
  },
  capabilities = capabilities,
  on_attach = on_attach
})

lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach
})

lspconfig.sourcekit.setup({
  capabilities = capabilities,
  on_attach = on_attach
})

lspconfig.omnisharp.setup({
  cmd = { "/Users/jeffknaggs/.local/share/nvim/lsp_servers/omnisharp/omnisharp/run", "--languageserver" , "--hostPID", tostring(pid) },
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.yamlls.setup({
  settings = {
    yaml = {
      schemas = {
        ["https://bitbucket.org/atlassianlabs/atlascode/raw/main/resources/schemas/pipelines-schema.json"] = "./bitbucket-pipelines.yml",
        ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.0/schema.yaml"] = "./schema.yml"
      }
    }
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
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
