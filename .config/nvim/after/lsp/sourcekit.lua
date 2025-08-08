--- @type vim.lsp.Config
return {
  root_markers = { "Package.swift" },
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
}
