local g = vim.g
local opt = vim.opt

opt.clipboard = "unnamedplus"
opt.swapfile = false
-- opt.completeopt = 'menuone,noinsert,noselect'
opt.completeopt = "menu,menuone,noselect"

if g.neovide then
  opt.guifont = "Iosevka Term Curly:h10"
  g.neovide_scale_factor = 1.0
  g.neovide_cursor_animation_length = 0
end

-- ??
opt.mouse = ""
opt.backspace = "indent,eol,start" -- FIXME
opt.signcolumn = "yes:1"           -- FIXME
opt.title = true                   -- FIXME
opt.formatoptions = "tcqronj"      -- FIXME
opt.ruler = true                   -- FIXME
opt.wrap = false                   -- FIXME
-- opt.listchars:append({ eol = "↴", trail = "▫", space = "-" })
-- opt.listchars.eol = "↴"
-- opt.list = true
-- opt.list = true                    -- FIXME
-- opt.listchars = {
--   tab = ":",
--   trail = "▫",
--   eol = "↴",
-- }
opt.cursorline = true
opt.autowrite = true
opt.autowriteall = true
opt.autoread = true
opt.autoindent = true

opt.number = true         -- Show line number
opt.showmatch = true      -- Highlight matching parenthesis
opt.foldmethod = "marker" -- Enable folding (default 'foldmarker')
--opt.colorcolumn = '80' -- Line lenght marker at 80 columns
opt.splitright = true     -- Vertical split to the right
opt.splitbelow = true     -- Horizontal split to the bottom
opt.ignorecase = true     -- Ignore case letters when search
opt.smartcase = true      -- Ignore lowercase for the whole pattern
opt.linebreak = true      -- Wrap on word boundary
opt.termguicolors = true  -- Enable 24-bit RGB colors
opt.laststatus = 3        -- Set global statusline

opt.expandtab = true      -- Use spaces instead of tabs
opt.shiftwidth = 2        -- Shift 2 spaces when tab
opt.tabstop = 2           -- 1 tab == 2 spaces
--opt.smartindent = true    -- Autoindent new lines

opt.hidden = true     -- Enable background buffers
opt.history = 100     -- Remember N lines in history
opt.lazyredraw = true -- Faster scrolling
opt.synmaxcol = 240   -- Max column for syntax highlight
opt.updatetime = 700  -- ms to wait for trigger an event

opt.shortmess:append("sI")

-- Disable builtins plugins
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit",
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end
