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
vim.opt.background = "dark"
