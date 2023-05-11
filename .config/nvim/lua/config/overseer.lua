----------------
-- Overseer
--
-- https://github.com/stevearc/overseer.nvim
----------------

local overseer = require("overseer").setup()
require("dressing").setup()

vim.api.nvim_create_user_command("OverseerRestartLast", function()
  local tasks = overseer.list_tasks({ recent_first = true })

  if vim.tbl_isempty(tasks) then
    vim.notify("No tasks found", vim.log.levels.WARN)
  else
    overseer.run_action(tasks[1], "restart")
  end
end, {})
