--- @type vim.lsp.Config
return {
  settings = {
    eslint = {
      useFlatConfig = true,
      experimental = {
        useFlatConfig = true,
      },
      workingDirectories = { { mode = "auto" } },
      -- Use push diagnostics (classic mode) instead of pull
      diagnostics = { mode = "openFilesOnly" },
    },
  },
  handlers = {
    -- Suppress the textDocument/diagnostic error from pull-mode
    ["textDocument/diagnostic"] = function() end,
  },
}
