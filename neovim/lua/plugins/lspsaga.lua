local status, saga = pcall(require, "lspsaga")
if (not status) then return end
-- local provider = require 'lspsaga.provider'

-- lua
saga.init_lsp_saga {
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  border_style = 'round',
}
