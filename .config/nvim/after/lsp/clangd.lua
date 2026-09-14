local clangd_allowlist = {
  vim.env.HOME .. "/.platformio/packages/toolchain-*/bin/*",
  "/usr/bin/*", -- if you want to allow all compilers installed here
  -- you can add other compiler directories here
}

--- @type vim.lsp.Config
return {
  cmd = {
    "clangd",
    "--query-driver=" .. table.concat(clangd_allowlist, ","),
  },
}
