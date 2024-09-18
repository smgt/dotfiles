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
-- barbar
-- vim.keymap.set("n", "<C-p>", ":BufferNext<CR>", opts)
-- vim.keymap.set("n", "<C-o>", ":BufferPrevious<CR>", opts)
-- bufferline
vim.keymap.set("n", "<C-p>", ":BufferLineCycleNext<CR>", opts)
vim.keymap.set("n", "<C-o>", ":BufferLineCyclePrev<CR>", opts)

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
vim.keymap.set("n", "<leader>im", "<cmd>Telescope goimpl", opts)

-- Trouble
--
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", opts)
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", opts)
vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", opts)
vim.keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", opts)


-- Window plugin
vim.keymap.set("n", "<C-w>z", "<cmd>WindowsMaximize<CR>", opts)
vim.keymap.set("n", "<C-w>_", "<cmd>WindowsMaximizeVertically<CR>", opts)
vim.keymap.set("n", "<C-w>|", "<cmd>WindowsMaximizeHorizontally<CR>", opts)
vim.keymap.set("n", "<C-w>=", "<cmd>WindowsEqualize<CR>", opts)
