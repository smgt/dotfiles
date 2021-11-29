local saga = require 'lspsaga'
local provider = require 'lspsaga.provider'

-- lua
saga.init_lsp_saga {
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  border_style = "round",
}


local opts = { noremap=true, silent=true }
-- vim.api.nvim_set_keymap('n', 'gd', ':Lspsaga preview_definition<CR>', opts)
local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
buf_set_keymap('n', '<space>rn', '<cmd>lua require("lspsaga.rename").rename()<CR>', opts)
