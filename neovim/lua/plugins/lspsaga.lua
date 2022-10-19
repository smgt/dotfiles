local status, saga = pcall(require, "lspsaga")
if (not status) then return end

-- lua
saga.init_lsp_saga {
  border_style = 'rounded',
  diagnostic_header = { " ", " ", " ", "ﴞ " },
  max_preview_lines = 20,
  -- use emoji lightbulb in default
  code_action_icon = "💡",
  finder_icons = {
    def = '  ',
    ref = '諭 ',
    link = '  ',
  },
}
