local opts = { noremap = true, silent = true }

vim.g.mapleader = ","

-- General
--
vim.keymap.set("i", "<Up>", "<NOP>", opts)
vim.keymap.set("i", "<Down>", "<NOP>", opts)
vim.keymap.set("i", "<Left>", "<NOP>", opts)
vim.keymap.set("i", "<Right>", "<NOP>", opts)
vim.keymap.set("", "<Up>", "<NOP>", opts)
vim.keymap.set("", "<Down>", "<NOP>", opts)
vim.keymap.set("", "<Left>", "<NOP>", opts)
vim.keymap.set("", "<Right>", "<NOP>", opts)

-- vim.keymap.set('n', '<C-p>', ':tabnext<CR>', opts)
-- vim.keymap.set('n', '<C-o>', ':tabprev<CR>', opts)
vim.keymap.set("n", "<C-p>", ":BufferNext<CR>", opts)
vim.keymap.set("n", "<C-o>", ":BufferPrevious<CR>", opts)

-- TMUX
--
vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", opts)
vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", opts)
vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", opts)
vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", opts)
vim.keymap.set("n", "<C-\\>", ":TmuxNavigatePrevious<CR>", opts)

-- DAP
--
vim.keymap.set("n", "<F5>", '<cmd>lua require"dap".continue()<CR>', opts)
vim.keymap.set("n", "<F6>", '<cmd>lua require"dap".step_over()<CR>', opts)
vim.keymap.set("n", "<F7", '<cmd>lua require"dap".step_into()<CR>', opts)
vim.keymap.set("n", "<F8>", '<cmd>lua require"dap".step_out()<CR>', opts)
vim.keymap.set("n", "<F9>", '<cmd>lua require"dap".terminate()<CR>', opts)
vim.keymap.set("n", "<space>b", '<cmd>lua require"dap".toggle_breakpoint()<CR>', opts)

-- Telescope
--
vim.keymap.set("n", "<Leader>p", "<cmd>Telescope find_files<CR>", opts)
vim.keymap.set("n", "<Leader>l", "<cmd>Telescope live_grep<CR>", opts)
vim.keymap.set("n", "<Leader>b", "<cmd>Telescope buffers<CR>", opts)
vim.keymap.set("n", ";;", "<cmd>Telescope help_tags<CR>", opts)

-- Barbar
--
-- Move to previous/next
vim.keymap.set("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
vim.keymap.set("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
-- Re-order to previous/next
vim.keymap.set("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
vim.keymap.set("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
-- Goto buffer in position...
vim.keymap.set("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
vim.keymap.set("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
vim.keymap.set("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
vim.keymap.set("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
vim.keymap.set("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
vim.keymap.set("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
vim.keymap.set("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
vim.keymap.set("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
vim.keymap.set("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
vim.keymap.set("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)
-- Pin/unpin buffer
vim.keymap.set("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
-- Close buffer
vim.keymap.set("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
-- vim.keymap.set('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
-- Sort automatically by...
vim.keymap.set("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
vim.keymap.set("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", opts)
vim.keymap.set("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", opts)
vim.keymap.set("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opts)

vim.keymap.set("n", "<leader>im", "<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<CR>]]", opts)

-- Window plugin
vim.keymap.set("n", "<C-w>z", "<cmd>WindowsMaximize<CR>", opts)
vim.keymap.set("n", "<C-w>_", "<cmd>WindowsMaximizeVertically<CR>", opts)
vim.keymap.set("n", "<C-w>|", "<cmd>WindowsMaximizeHorizontally<CR>", opts)
vim.keymap.set("n", "<C-w>=", "<cmd>WindowsEqualize<CR>", opts)

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used
