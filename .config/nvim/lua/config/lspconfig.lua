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
    force_max_height = true,
    layout = "float",
  },
  ui = {
    title = true,
    border = "rounded",
    winblend = 5,
    expand = "",
    collapse = "",
    preview = " ",
    code_action = "💡",
    hover = " ",
  },
  symbol_in_winbar = { enable = true, separator = "  " },
})

local lsp_formatting = function()
  vim.lsp.buf.format({
    filter = function(client)
      -- apply whatever logic you want (in this example, we'll only use null-ls)
      return client.name == "null-ls"
    end,
    -- bufnr = bufnr,
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
  { virtual_text = { prefix = "⏹" } }
)

local capabilities = cmp.default_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP Attach",
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { buffer = true })
    end

    bufmap("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
    bufmap("n", "gi", "<cmd>Lspsaga goto_type_definition<CR>")
    bufmap("n", "gK", "<cmd>Lspsaga peek_type_definition<CR>")
    bufmap("n", "gr", "<cmd>Lspsaga finder<CR>")

    bufmap("n", "K", "<cmd>Lspsaga hover_doc<CR>")

    bufmap("n", "[g", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
    bufmap("n", "]g", "<cmd>Lspsaga diagnostic_jump_next<CR>")

    bufmap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>")
    bufmap("n", "<leader>qf", "<cmd>Lspsaga code_action<CR>")
    bufmap("n", "<leader>o", "<cmd>Lspsaga outline<CR>")

    bufmap("n", "<space>e", "<cmd>Lspsaga show_line_diagnostics<CR>")

    -- if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      callback = function()
        lsp_formatting()
      end,
    })
    -- end
  end,
})

null_ls.setup({
  debug = true,
  sources = {
    -- JavaScript
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
  -- on_attach = on_attach,
})
