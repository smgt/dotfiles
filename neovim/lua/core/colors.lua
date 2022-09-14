-- vim.cmd 'colorscheme material'
-- vim.g.material_style = "oceanic"

-- Tokyo night
-- local tokyo_colors = require("tokyonight.colors").setup()
-- require('tokyonight').setup({
--   style = "storm",
--   sidebars = { "qf", "vista_kind", "terminal", "packer", "nvimtree" },
--   on_colors = function(c)
--     c.border = tokyo_colors.orange
--   end
-- })
-- vim.g.tokyonight_style = "storm"
-- vim.g.tokyonight_italic_functions = true
-- vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer", "nvimtree" }
-- vim.g.tokyonight_colors = { border = "blue" }

-- Catpuccino
vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha

local colors = require("catppuccin.palettes").get_palette()
require("catppuccin").setup({

  highlight_overrides = {
    all = {
      VertSplit = { fg = colors.rosewater },
    }
  },
  compile = {
    enabled = true,
    path = vim.fn.stdpath "cache" .. "/catppuccin"
  },
  integrations = {
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
  }
})

-- Load the colorscheme
vim.cmd [[colorscheme catppuccin]]
