local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true }

-- General
--
map('i', '<Up>', '<NOP>', opts)
map('i', '<Down>', '<NOP>', opts)
map('i', '<Left>', '<NOP>', opts)
map('i', '<Right>', '<NOP>', opts)
map('', '<Up>', '<NOP>', opts)
map('', '<Down>', '<NOP>', opts)
map('', '<Left>', '<NOP>', opts)
map('', '<Right>', '<NOP>', opts)

map('n', '<C-p>', ':tabnext<CR>', opts)
map('n', '<C-o>', ':tabprev<CR>', opts)

map('n', '<C-h>', ':TmuxNavigateLeft<CR>', opts)
map('n', '<C-j>', ':TmuxNavigateDown<CR>', opts)
map('n', '<C-k>', ':TmuxNavigateUp<CR>', opts)
map('n', '<C-l>', ':TmuxNavigateRight<CR>', opts)
map('n', '<C-\\>', ':TmuxNavigatePrevious<CR>', opts)

-- DAP
--
map('n', '<F5>', '<cmd>lua require"dap".continue()<CR>', opts)
map('n', '<F6>', '<cmd>lua require"dap".step_over()<CR>', opts)
map('n', '<F7', '<cmd>lua require"dap".step_into()<CR>', opts)
map('n', '<F8>', '<cmd>lua require"dap".step_out()<CR>', opts)
map('n', '<F9>', '<cmd>lua require"dap".terminate()<CR>', opts)
map('n', '<space>b',  '<cmd>lua require"dap".toggle_breakpoint()<CR>', opts)
-- map('n', '<F5>', '<cmd>lua require"dap".continue()<CR>', opts)

-- Telescope
--
map('n', '<Leader>p', '<cmd>Telescope find_files<CR>', opts)
map('n', '<Leader>l', '<cmd>Telescope live_grep<CR>', opts)
map('n', '<Leader>b', '<cmd>Telescope buffers<CR>', opts)
map('n', ';;', '<cmd>Telescope help_tags<CR>', opts)



