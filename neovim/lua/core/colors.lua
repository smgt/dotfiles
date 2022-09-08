-- vim.cmd 'colorscheme material'
-- vim.g.material_style = "oceanic"

-- Tokyo night
local tokyo_colors = require("tokyonight.colors").setup()
require('tokyonight').setup({
  style = "storm",
  sidebars = { "qf", "vista_kind", "terminal", "packer", "nvimtree" },
  on_colors = function(c)
    c.border = tokyo_colors.orange
  end
})
-- vim.g.tokyonight_style = "storm"
-- vim.g.tokyonight_italic_functions = true
-- vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer", "nvimtree" }
-- vim.g.tokyonight_colors = { border = "blue" }

-- Load the colorscheme
vim.cmd [[colorscheme tokyonight]]
