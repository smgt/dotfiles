local dashboard = require("alpha.themes.dashboard")
local dch1 = {
  "   ██████   █████                                ███                 ",
  "░░██████ ░░███                                ░░░                  ",
  " ░███░███ ░███   ██████   ██████  █████ █████ ████  █████████████  ",
  " ░███░░███░███  ███░░███ ███░░███░░███ ░░███ ░░███ ░░███░░███░░███ ",
  " ░███ ░░██████ ░███████ ░███ ░███ ░███  ░███  ░███  ░███ ░███ ░███ ",
  " ░███  ░░█████ ░███░░░  ░███ ░███ ░░███ ███   ░███  ░███ ░███ ░███ ",
  " █████  ░░█████░░██████ ░░██████   ░░█████    █████ █████░███ █████",
  "░░░░░    ░░░░░  ░░░░░░   ░░░░░░     ░░░░░    ░░░░░ ░░░░░ ░░░ ░░░░░ ",
}

dashboard.section.header.val = dch1
dashboard.section.header.opts.hl = "DiagnosticError"

local function button(sc, txt, cmd, hl)
  local b = dashboard.button(sc, txt, cmd)
  b.opts.hl = hl or "Title"
  b.opts.hl_shortcut = "Comment"
  return b
end

dashboard.section.buttons.val = {
  button("tf", "󰍉  Find file", ":Telescope find_files<CR>"),
  button("fn", "  New file", "<cmd>ene <CR>"),
  button("ge", "  Open explorer", ":NvimTreeOpen<CR>"),
  button("tg", "󰈞  Find word", ":Telescope live_grep<CR>"),
  button(
    "tr",
    "  Recent files",
    ':lua require"telescope.builtin".oldfiles(require("telescope.themes").get_dropdown({ previewer = false }))<CR>'
  ),
  { type = "padding", val = 1 },
  button("cu", "󰏔  Update Plugins", ":PackerSync<CR>"),
  button("ch", "  Health Check", ':lua require"nvpunk.util.healthcheck"()<CR>'),
  { type = "padding", val = 1 },
  button("q", "󰗼  Quit", ":qa<CR>", "DiagnosticError"),
}
