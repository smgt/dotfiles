require('dap-go').setup()
local dap = require('dap')
local dapui = require('dapui')
-- local widgets = require('dap.ui.widgets')
local utils = require('utils')


-- vim.api.nvim_set_keymap('n', '<F5>', '<cmd>lua require"dap".continue()<CR>', opts)
utils.set_keymaps('n', '<F5>', '<cmd>lua require"dap".continue()<CR>')
utils.set_keymaps('n', '<F6>', '<cmd>lua require"dap".step_over()<CR>')
utils.set_keymaps('n', '<F7', '<cmd>lua require"dap".step_into()<CR>')
utils.set_keymaps('n', '<F8>', '<cmd>lua require"dap".step_out()<CR>')
utils.set_keymaps('n', '<F9>', '<cmd>lua require"dap".terminate()<CR>')
utils.set_keymaps('n', '<space>b',  '<cmd>lua require"dap".toggle_breakpoint()<CR>')

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
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.25, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.25 },
      { id = "stacks", size = 0.25 },
      -- { id = "watches", size = 00.25 },
    },
    size = 40,
    position = "left", -- Can be "left", "right", "top", "bottom"
  },
  tray = {
    elements = { "repl" },
    size = 10,
    position = "bottom", -- Can be "left", "right", "top", "bottom"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
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
