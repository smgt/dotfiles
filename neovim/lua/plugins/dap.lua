require('dap-go').setup()
local dap = require('dap')
local dapui = require('dapui')
-- local widgets = require('dap.ui.widgets')

dapui.setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
  },
  layouts = {
    {
      elements = {
        'scopes',
        'breakpoints',
        'stacks',
        'watches',
      },
      size = 40,
      position = 'left',
    },
    {
      elements = {
        'repl',
        'console',
      },
      size = 10,
      position = 'bottom',
    },
  },
  windows = { indent = 1 },
})

-- Open dap-ui when a new session is started
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

-- Close dap-ui when a session is terminated
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

-- Close dap-ui when a session is over
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- buf_set_keymap('n', '<leader>B',  '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', opts)
-- buf_set_keymap('n', '<leader>lp',  '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', opts)
-- buf_set_keymap('n', '<leader>dr',  '<cmd>lua require"dap".repl.open()<CR>', opts)
-- buf_set_keymap('n', '<leader>dl',  '<cmd>lua require"dap".run_last()<CR>', opts)
-- <F5><F4><F3><F2>
-- dap.configurations.go = {
--   {
--     type = "go",
--     name = "Debug",
--     request = "launch",
--     program = "${file}"
--   },
--   {
--     type = "go",
--     name = "Debug test", -- configuration for debugging test files
--     request = "launch",
--     mode = "test",
--     program = "${file}"
--   },
--   -- works with go.mod packages and sub packages
--   {
--     type = "go",
--     name = "Debug test (go.mod)",
--     request = "launch",
--     mode = "test",
--     program = "./${relativeFileDirname}"
--   }
-- }

-- dap.adapters.go = {
--   type = "server",
--   host = "127.0.0.1",
--   port = 38697,
-- }
