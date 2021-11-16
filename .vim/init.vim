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
        ["<c-m>"] = actions.toggle_selection,
      }
    },
    dynamic_preview_title = true
  }
})

telescope.load_extension('fzf')


local lspconfig = require("lspconfig")
local coq = require("coq")

local buf_map = function(bufnr, mode, lhs, rhs, opts)
  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
    silent = true,
  })
end

local on_attach = function(client, bufnr)
  vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
  vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
  vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
  vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
  vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
  vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
  vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
  vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
  vim.cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
  vim.cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
  vim.cmd("command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
  vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

  buf_map(bufnr, "n", "gd", ":LspDef<CR>")
  buf_map(bufnr, "n", "gr", ":LspRefs<CR>")
  buf_map(bufnr, "n", "K", ":LspHover<CR>")
  buf_map(bufnr, "n", "[g", ":LspDiagPrev<CR>")
  buf_map(bufnr, "n", "]g", ":LspDiagNext<CR>")
  buf_map(bufnr, "n", "<leader>rn", ":LspRename<CR>")

  if client.resolved_capabilities.document_formatting then
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  end
end

lspconfig.tsserver.setup({
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    local ts_utils = require("nvim-lsp-ts-utils")
    ts_utils.setup({
      eslint_bin = "eslint_d",
      eslint_enable_diagnostics = true,
      eslint_enable_code_actions = true,
      enable_formatting = true,
      formatter = "prettier",
    })

    ts_utils.setup_client(client)

    buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
    buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
    buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")

    on_attach(client, bufnr)
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
  end,
  cmd = { "/Users/jeffknaggs/.local/share/nvim/lsp_servers/omnisharp/omnisharp/run", "--languageserver" , "--hostPID", tostring(pid) },
})


require("null-ls").config({})
lspconfig["null-ls"].setup({ on_attach = on_attach })

EOF
