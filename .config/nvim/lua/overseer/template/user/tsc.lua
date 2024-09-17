return {
  name = "TSC",
  builder = function()
    return {
      cmd = { "npx" },
      args = { "tsc" },
      components = {
        { "on_output_parse", problem_matcher = "$tsc" },
        { "on_output_quickfix", open = true },
        "default",
      },
    }
  end,
  condition = {
    filetype = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
  },
}
