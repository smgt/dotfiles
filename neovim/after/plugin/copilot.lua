local map = vim.api.nvim_set_keymap
map("i", "<C-p>", [[copilot#Accept("\<CR>")]], { noremap = true, silent = true, expr = true, script = true })

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
