local status, saga = pcall(require, "lspsaga")
if not status then
  return
end

-- lua
saga.setup({
  ui = {
    title = true,
    border = "rounded",
    code_action = "💡",
  },
  preview = {
    lines_below = 30,
    lines_above = 0,
  },
  lightbulb = {
    enable = true,
  },
  outline = {
    win_width = 50,
  },
  symbol_in_winbar = {
    enable = false,
    separator = " ",
    ignore_patterns = {},
    hide_keyword = true,
    show_file = false,
    folder_level = 2,
    respect_root = false,
    color_mode = true,
  },
})
