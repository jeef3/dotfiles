----------------
-- DAP
--
-- https://github.com/mfussenegger/nvim-dap
----------------

local dap = require("dap")
local dapui = require("dapui")
dapui.setup()
require("nvim-dap-virtual-text").setup()

dap.adapters.node2 = {
  type = "executable",
  command = os.getenv("HOME")
    .. "/.local/share/nvim/mason/bin/node-debug2-adapter",
}

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = os.getenv("HOME")
      .. "/.local/share/nvim/mason/bin/js-debug-adapter",
    args = { "${port}" },
  },
}

dap.adapters.chrome = {
  type = "executable",
  command = os.getenv("HOME")
    .. "/.local/share/nvim/mason/bin/chrome-debug-adapter",
}

dap.adapters.firefox = {
  type = "executable",
  command = os.getenv("HOME")
    .. "/.local/share/nvim/mason/bin/firefox-debug-adapter",
}

local debugWithFirefox = {
  name = "Debug with Firefox",
  type = "firefox",
  request = "launch",
  reAttach = true,
  url = "http://localhost:3000/",
  webRoot = "${workspaceFolder}",
  firefoxExecutable = "/Applications/Firefox\\ Developer\\ Edition.app/Contents/MacOS/firefox -start-debugger-server",
}

local attachToFirefox = {
  name = "Attach to Firefox",
  type = "firefox",
  request = "attach",
  url = "https://localdev.cleverfirstaid.com:5173/",
  webRoot = "${workspaceFolder}",
}

for _, language in ipairs({
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
}) do
  dap.configurations[language] = {
    {
      -- For this to work you need to make sure the node process is started with the `--inspect` flag.
      name = "Attach to process",
      type = "pwa-node",
      request = "attach",
      processId = require("dap.utils").pick_process,
    },
    {
      name = "Open in Chrome",
      type = "chrome",
      request = "launch",
      url = "https://localdev.cleverfirstaid.com:5173",
      webRoot = "${workspaceFolder}",
    },
    {
      name = "Attach to Chrome",
      type = "chrome",
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}",
    },
  }
end

-- dap.configurations.javascript = {
--   {
--     name = "Launch",
--     type = "node2",
--     request = "launch",
--     program = "${file}",
--     cwd = vim.fn.getcwd(),
--     sourceMaps = true,
--     protocol = "inspector",
--     console = "integratedTerminal",
--   },
-- }

-- dap.configurations.typescript = {
--   {
--     name = "Launch",
--     type = "node2",
--     request = "launch",
--     program = "${file}",
--     cwd = "${workspaceFolder}",
--     env = {
--       -- Use remote debugging port.
--       PLAYWRIGHT_CHROMIUM_DEBUG_PORT = 9222,
--       -- Run Playwright in debug mode.
--       PWDEBUG = true,
--     },
--   },
--   {
--     name = "Attach to Playwright",
--     type = "chrome",
--     request = "attach",
--     -- port = 9222,
--     -- webRoot = "${workspaceFolder}",
--     processId = require("dap.utils").pick_process,
--   },
--   debugWithChrome,
--   debugWithFirefox,
--   attachToFirefox,
-- }

-- dap.configurations.typescriptreact = {
--   debugWithChrome,
--   debugWithFirefox,
--   attachToFirefox,
-- }

-- Auto-open/close the debug UI
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close({})
end

vim.fn.sign_define("DapBreakpoint", {
  text = "",
  texthl = "DapBreakpoint",
  linehl = "DapBreakpointLine",
})
vim.fn.sign_define("DapBreakpointCondition", {
  text = "",
  texthl = "DapBreakpointCondition",
  linehl = "DapBreakpointConditionLine",
})
vim.fn.sign_define("DapLogPoint", {
  text = "",
  texthl = "DapLogPoint",
  linehl = "DapLogPointLine",
})
vim.fn.sign_define("DapStopped", {
  text = "",
  texthl = "DapStopped",
  linehl = "DapStoppedLine",
})
vim.fn.sign_define("DapBreakpointRejected", {
  text = "",
  texthl = "DapBreakpointRejected",
  linehl = "DapBreakpointRejectedLine",
})

vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<Leader>lp", function()
  dap.set_breakpoint(nil, nil, vim.fn.input("Message: "))
end)
