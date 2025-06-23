--- @type vim.lsp.Config
return {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      telemetry = { enable = false },
    },
  },
}
