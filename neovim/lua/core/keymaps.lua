local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = ','

-- General
--
map('i', '<Up>', '<NOP>')
map('i', '<Down>', '<NOP>')
map('i', '<Left>', '<NOP>')
map('i', '<Right>', '<NOP>')
map('', '<Up>', '<NOP>')
map('', '<Down>', '<NOP>')
map('', '<Left>', '<NOP>')
map('', '<Right>', '<NOP>')

map('n', '<C-p>', ':tabnext<CR>')
map('n', '<C-o>', ':tabprev<CR>')

-- TMUX
--
map('n', '<C-h>', ':TmuxNavigateLeft<CR>')
map('n', '<C-j>', ':TmuxNavigateDown<CR>')
map('n', '<C-k>', ':TmuxNavigateUp<CR>')
map('n', '<C-l>', ':TmuxNavigateRight<CR>')
map('n', '<C-\\>', ':TmuxNavigatePrevious<CR>')

-- DAP
--
map('n', '<F5>', '<cmd>lua require"dap".continue()<CR>')
map('n', '<F6>', '<cmd>lua require"dap".step_over()<CR>')
map('n', '<F7', '<cmd>lua require"dap".step_into()<CR>')
map('n', '<F8>', '<cmd>lua require"dap".step_out()<CR>')
map('n', '<F9>', '<cmd>lua require"dap".terminate()<CR>')
map('n', '<space>b', '<cmd>lua require"dap".toggle_breakpoint()<CR>')
-- map('n', '<F5>', '<cmd>lua require"dap".continue()<CR>')

-- Telescope
--
map('n', '<Leader>p', '<cmd>Telescope find_files<CR>')
map('n', '<Leader>l', '<cmd>Telescope live_grep<CR>')
map('n', '<Leader>b', '<cmd>Telescope buffers<CR>')
map('n', ';;', '<cmd>Telescope help_tags<CR>')
