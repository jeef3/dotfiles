----------------
-- DAP
--
-- https://github.com/mfussenegger/nvim-dap
----------------

local dap = require("dap")
dap.adapters.node2 = {
  type = "executable",
  command = "node",
  args = {
    os.getenv("HOME") .. "/.vim/vscode-node-debug2/out/src/nodeDebug.js",
  },
}
dap.configurations.javascript = {
  {
    name = "Launch",
    type = "node2",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = "Attach to process",
    type = "node2",
    request = "attach",
    processId = require("dap.utils").pick_process,
  },
}

dap.adapters.firefox = {
  type = "executable",
  command = "node",
  args = {
    os.getenv("HOME") .. "/.vim/vscode-firefox-debug/dist/adapter.bundle.js",
  },
}
dap.configurations.typescript = {
  name = "Debug with Firefox",
  type = "firefox",
  request = "launch",
  reAttach = true,
  url = "http://localhost:3000",
  webRoot = "${workspaceFolder}",
  firefoxExecutable = "/usr/bin/firefox",
}

local dapui = require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
