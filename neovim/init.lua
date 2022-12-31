if vim.fn.has("nvim-0.8") ~= 1 then
	vim.api.nvim_err_writeln("Dotfiles requires Neovim 0.8.0 or greater")
end

require("packer_init")
require("core/options")
require("core/autocmds")
require("core/keymaps")
require("core/colors")
require("core/statusline")

require("plugins/nvim-tree")
require("plugins/cmp")
require("plugins/dap")
require("plugins/lspsaga")
require("plugins/mason") -- before nullls and lspconfig
require("plugins/lspconfig")
require("plugins/nullls")
require("plugins/lualine")
require("plugins/sidebar")
require("plugins/treesitter")
require("plugins/telescope")
require("plugins/alpha_dashboard")
