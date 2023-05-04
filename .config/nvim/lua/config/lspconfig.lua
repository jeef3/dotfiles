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
  code_action = {},
  lightbulb = { enable = false },
  finder = {
    max_height = 0.8,
    force_max_height = false,
  },
  ui = {
    title = true,
    border = "rounded",
    -- border = { "-", "-", "-", ":", ":", ":", ":", "p" },
    -- border = {
    --   "🭽",
    --   "▔",
    --   "🭾",
    --   "▕",
    --   "🭿",
    --   "▁",
    --   "🭼",
    --   "▏",
    -- },
    winblend = 5,
    expand = "",
    collapse = "",
    preview = " ",
    code_action = "💡",
    hover = " ",
  },
  symbol_in_winbar = { enable = false, separator = "  " },
})

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      -- apply whatever logic you want (in this example, we'll only use null-ls)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end

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

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  { virtual_text = { prefix = " ●" } }
)

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

local capabilities =
  cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local keymap = vim.keymap.set
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>", bufopts)
  keymap("n", "gr", "<cmd>Lspsaga lsp_finder<CR>")
  keymap("n", "gK", "<cmd>Lspsaga peek_type_definition<CR>")

  keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", bufopts)

  keymap("n", "[g", "<cmd>Lspsaga diagnostic_jump_prev<CR>", bufopts)
  keymap("n", "]g", "<cmd>Lspsaga diagnostic_jump_next<CR>", bufopts)

  keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", bufopts)
  keymap("n", "<leader>qf", "<cmd>Lspsaga code_action<CR>", bufopts)
  keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", bufopts)

  keymap("n", "<space>e", "<cmd>Lspsaga show_line_diagnostics<CR>", bufopts)

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end

  -- Workaround for broken OmniSharp
  if client.name == "omnisharp" then
    client.server_capabilities.semanticTokensProvider = {
      full = vim.empty_dict(),
      legend = {
        tokenModifiers = { "static_symbol" },
        tokenTypes = {
          "comment",
          "excluded_code",
          "identifier",
          "keyword",
          "keyword_control",
          "number",
          "operator",
          "operator_overloaded",
          "preprocessor_keyword",
          "string",
          "whitespace",
          "text",
          "static_symbol",
          "preprocessor_text",
          "punctuation",
          "string_verbatim",
          "string_escape_character",
          "class_name",
          "delegate_name",
          "enum_name",
          "interface_name",
          "module_name",
          "struct_name",
          "type_parameter_name",
          "field_name",
          "enum_member_name",
          "constant_name",
          "local_name",
          "parameter_name",
          "method_name",
          "extension_method_name",
          "property_name",
          "event_name",
          "namespace_name",
          "label_name",
          "xml_doc_comment_attribute_name",
          "xml_doc_comment_attribute_quotes",
          "xml_doc_comment_attribute_value",
          "xml_doc_comment_cdata_section",
          "xml_doc_comment_comment",
          "xml_doc_comment_delimiter",
          "xml_doc_comment_entity_reference",
          "xml_doc_comment_name",
          "xml_doc_comment_processing_instruction",
          "xml_doc_comment_text",
          "xml_literal_attribute_name",
          "xml_literal_attribute_quotes",
          "xml_literal_attribute_value",
          "xml_literal_cdata_section",
          "xml_literal_comment",
          "xml_literal_delimiter",
          "xml_literal_embedded_expression",
          "xml_literal_entity_reference",
          "xml_literal_name",
          "xml_literal_processing_instruction",
          "xml_literal_text",
          "regex_comment",
          "regex_character_class",
          "regex_anchor",
          "regex_quantifier",
          "regex_grouping",
          "regex_alternation",
          "regex_text",
          "regex_self_escaped_character",
          "regex_other_escape",
        },
      },
      range = true,
    }
  end
end

null_ls.setup({
  debug = true,
  sources = {
    -- JavaScript
    -- null_ls.builtins.diagnostics.eslint_d,
    -- null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.formatting.prettierd,

    -- C, C++ (Arduino),
    -- null_ls.builtins.formatting.astyle,

    -- YAML
    null_ls.builtins.diagnostics.yamllint,
    -- null_ls.builtins.formatting.yamlfix,
    -- null_ls.builtins.formatting.yamlfmt,

    -- Lua
    --null_ls.builtins.diagnostics.luacheck,
    null_ls.builtins.formatting.stylua,
  },
  on_attach = on_attach,
})

----------------
-- Languages
----------------

-- JavaScript/TypeScript
lspconfig.tsserver.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.cssls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- C/C++
lspconfig.ccls.setup({
  -- init_options = {
  --   compilationDatabaseDirectory = "build",

  --   index = { threads = 0 },
  --   clang = { excludeArgs = { "-frounding-math" } },
  -- },
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Python
lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- lspconfig.sourcekit.setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })

local omnisharp_bin = "/Users/jeffknaggs/.local/share/nvim/mason/bin/omnisharp"

lspconfig.omnisharp.setup({
  cmd = { omnisharp_bin },
  capabilities = capabilities,
  on_attach = on_attach,
})

-- lspconfig.csharp_ls.setup({
--   cmd = { "/Users/jeffknaggs/.local/share/nvim/mason/bin/csharp-ls" },
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })

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

lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
      completion = {
        callSnippet = "Replace",
      },
    },
  },
})

lspconfig.eslint.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
