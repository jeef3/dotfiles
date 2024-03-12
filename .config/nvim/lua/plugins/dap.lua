local mason = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/bin/")

return {
  ----------------
  -- DAP
  --
  -- Debug Adapter Protocol client implementation for Neovim
  --
  -- https://github.com/mfussenegger/nvim-dap
  ----------------
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "rcarriga/nvim-dap-ui" },
      { "theHamsta/nvim-dap-virtual-text" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = mason .. "js-debug-adapter",
          args = { "${port}" },
        },
      }

      dap.adapters["node2"] = {
        type = "executable",
        command = mason .. "node-debug2-adapter",
      }

      -- dap.adapters.chrome = {
      --   type = "executable",
      --   command = os.getenv("HOME")
      --     .. "/.local/share/nvim/mason/bin/chrome-debug-adapter",
      -- }

      -- dap.adapters.firefox = {
      --   type = "executable",
      --   command = os.getenv("HOME")
      --     .. "/.local/share/nvim/mason/bin/firefox-debug-adapter",
      -- }

      for _, language in ipairs({
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
      }) do
        dap.configurations[language] = {
          {
            name = "Launch",
            type = "pwa-node",
            request = "launch",
            program = "${file}",
          },
          {
            name = "Attach",
            type = "pwa-node",
            request = "attach",
            processId = require("dap.utils").pick_process,
          },
          {
            name = "Attach 2",
            type = "node2",
            request = "attach",
            processId = require("dap.utils").pick_process,
          },
          -- {
          --   -- For this to work you need to make sure the node process is started with the `--inspect` flag.
          --   name = "Attach to process",
          --   type = "pwa-node",
          --   request = "attach",
          --   processId = require("dap.utils").pick_process,
          -- },
          -- {
          --   name = "Open in Chrome",
          --   type = "chrome",
          --   request = "launch",
          --   url = "https://localdev.cleverfirstaid.com:5173",
          --   webRoot = "${workspaceFolder}",
          -- },
          -- {
          --   name = "Attach to Chrome",
          --   type = "chrome",
          --   request = "attach",
          --   program = "${file}",
          --   cwd = vim.fn.getcwd(),
          --   sourceMaps = true,
          --   protocol = "inspector",
          --   port = 9222,
          --   webRoot = "${workspaceFolder}",
          -- },
        }
      end

      -- Auto-open/close the debug UI
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
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
    end,
  },
}
