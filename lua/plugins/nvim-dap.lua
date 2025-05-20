return {
  -- Core DAP plugin
  {
    'mfussenegger/nvim-dap',
    config = function()
      vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '➡️', texthl = '', linehl = '', numhl = '' })

      local dap = require 'dap'

      dap.adapters.lldb = {
        type = 'executable',
        command = '/usr/bin/lldb-vscode', -- Adjust path if necessary
        name = 'lldb',
      }

      dap.configurations.rust = {
        {
          name = 'Launch',
          type = 'lldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},

          -- 💡 If you use `rust-analyzer`, this helps source maps work better:
          runInTerminal = false,
        },
      }

      dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = vim.fn.stdpath 'data' .. '/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
      }

      dap.configurations.cpp = {
        {
          name = 'Launch file (GDB)',
          type = 'cppdbg',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopAtEntry = false,
          setupCommands = {
            {
              text = '-enable-pretty-printing',
              description = 'Enable GDB pretty printing',
              ignoreFailures = true,
            },
          },
        },
      }

      dap.configurations.c = dap.configurations.cpp

      -- DAP keymaps
      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<F5>', function()
        dap.continue()
      end, opts)
      vim.keymap.set('n', '<F10>', function()
        dap.step_over()
      end, opts)
      vim.keymap.set('n', '<F11>', function()
        dap.step_into()
      end, opts)
      vim.keymap.set('n', '<F12>', function()
        dap.step_out()
      end, opts)
      vim.keymap.set('n', '<Leader>b', function()
        dap.toggle_breakpoint()
      end, opts)
      vim.keymap.set('n', '<Leader>B', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, opts)
    end,
  },

  -- Optional: DAP UI for better UX
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    config = function()
      local dap, dapui = require 'dap', require 'dapui'
      dapui.setup()
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
      -- Add dapui-related keymap
      vim.keymap.set('n', '<Leader>dq', function()
        dap.terminate()
        dapui.close()
      end, { noremap = true, silent = true })
    end,
  },
}
