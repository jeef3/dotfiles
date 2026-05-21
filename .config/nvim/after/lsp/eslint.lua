--- @type vim.lsp.Config
return {
  settings = {
    eslint = {
      useFlatConfig = true,
      experimental = {
        useFlatConfig = true,
      },
      workingDirectories = { { mode = "auto" } },
    },
  },
}
