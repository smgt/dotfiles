require("packer_init")
require("core/options")
require("core/autocmds")
require("core/keymaps")
require("core/colors")
require("core/statusline")

require("plugins/mason")
require("plugins/nvim-tree")
require("plugins/cmp")
require("plugins/nullls") -- none-ls
--require("plugins/lint")
--require("plugins/formatter")
require("plugins/dap")
require("plugins/lspconfig")
require("plugins/lualine")
require("plugins/sidebar")
require("plugins/treesitter")
require("plugins/telescope")
require("plugins/alpha_dashboard")

-- Set background based on gsettings
local Job = require("plenary.job")
job = Job:new({
  command = "gsettings",
  args = { "get", "org.gnome.desktop.interface", "color-scheme" },
})
vim.opt.background = "dark"

--
-- if job:sync()[1] == "'prefer-dark'" then
--   vim.opt.background = "dark"
-- else
--   vim.opt.background = "light"
-- end
