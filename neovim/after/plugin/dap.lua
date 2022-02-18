--require('dapui').setup()
-- require('dap-go').setup()
local dap = require('dap')
-- local widgets = require('dap.ui.widgets')
local utils = require('utils')


-- vim.api.nvim_set_keymap('n', '<F5>', '<cmd>lua require"dap".continue()<CR>', opts)
utils.set_keymaps('n', '<F5>', '<cmd>lua require"dap".continue()<CR>')
utils.set_keymaps('n', '<F6>', '<cmd>lua require"dap".step_over()<CR>')
utils.set_keymaps('n', '<F7', '<cmd>lua require"dap".step_into()<CR>')
utils.set_keymaps('n', '<F8>', '<cmd>lua require"dap".step_out()<CR>')
utils.set_keymaps('n', '<space>b',  '<cmd>lua require"dap".toggle_breakpoint()<CR>')

-- buf_set_keymap('n', '<leader>B',  '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', opts)
-- buf_set_keymap('n', '<leader>lp',  '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', opts)
-- buf_set_keymap('n', '<leader>dr',  '<cmd>lua require"dap".repl.open()<CR>', opts)
-- buf_set_keymap('n', '<leader>dl',  '<cmd>lua require"dap".run_last()<CR>', opts)
-- <F5><F4><F3><F2>
dap.configurations.go = {
  {
    type = "go",
    name = "Debug",
    request = "launch",
    program = "${file}"
  },
  {
    type = "go",
    name = "Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}"
  },
  -- works with go.mod packages and sub packages 
  {
    type = "go",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}"
  } 
}

dap.adapters.go = {
  type = "server",
  host = "127.0.0.1",
  port = 38697,
}
