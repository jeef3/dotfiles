return {
  name = "ESLint",
  builder = function()
    -- local file = vim.fn.expand("%:p")
    return {
      cmd = { "npx" },
      args = { "eslint", "src" },
      components = {
        { "on_output_quickfix", open = true },
        { "on_output_parse", problem_matcher = "$eslint-stylish" },
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
