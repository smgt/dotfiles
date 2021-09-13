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
