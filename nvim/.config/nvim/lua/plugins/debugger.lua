return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- Fancy UI for the debugger
      { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
      -- Virtual text for variable values
      { "theHamsta/nvim-dap-virtual-text", opts = {} },
      -- Mason integration for easy adapter installation
      { "jay-babu/mason-nvim-dap.nvim" },
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()
      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = true,
        },
      }

      dap.configurations.c = dap.configurations.cpp
      -- Automatically open/close UI
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      -- Use mason-nvim-dap to install adapters
      require("mason-nvim-dap").setup({
        ensure_installed = { "python", "cppdbg" }, -- Add your languages here
        automatic_installation = true,
        handlers = {},
      })
    end,
  },
}
