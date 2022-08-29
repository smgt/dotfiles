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

-- Barbar
--
-- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>')
map('n', '<A-.>', '<Cmd>BufferNext<CR>')
-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>')
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>')
-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>')
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>')
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>')
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>')
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>')
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>')
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>')
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>')
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>')
map('n', '<A-0>', '<Cmd>BufferLast<CR>')
-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>')
-- Close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>')
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
-- map('n', '<C-p>', '<Cmd>BufferPick<CR>')
-- Sort automatically by...
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>')
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>')
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>')
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>')

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used
