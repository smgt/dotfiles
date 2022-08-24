-- Automatically install packer
PackerBootstrap = false
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  PackerBootstrap = true
  fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer_init.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Install plugins
return packer.startup(function(use)
  -- packer manages packer
  use { 'wbthomason/packer.nvim' }

  -- utils
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-commentary'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use {
    'ray-x/guihua.lua',
    run = 'cd lua/fzy && make'
  }
  use 'vim-scripts/ZoomWin'
  use 'chentau/marks.nvim'
  use 'junegunn/goyo.vim'
  use 'kyazdani42/nvim-tree.lua'

  -- git
  use 'gregsexton/gitv'
  use {
    'tpope/vim-fugitive',
    requires = {
      { 'tpope/vim-rhubarb' },
    },
  }

  -- tmux
  use 'benmills/vimux'
  use 'christoomey/vim-tmux-navigator'

  -- telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzy-native.nvim' },
      { 'nvim-telescope/telescope-symbols.nvim' },
      { 'nvim-telescope/telescope-dap.nvim' },
    }
  }

  -- Statusline
  use 'hoob3rt/lualine.nvim'

  -- Language support
  use 'vim-crystal/vim-crystal'
  use 'PyGamer0/vim-apl'
  use 'baruchel/vim-notebook'
  use 'hashivim/vim-terraform'
  use 'ellisonleao/glow.nvim'
  use {
    'ray-x/go.nvim',
    config = function()
      require('go').setup()
    end
}

  -- LSP + treesitter plugins
  use 'jose-elias-alvarez/null-ls.nvim' -- Linters etc
  use {
    "williamboman/mason.nvim", -- LSP installer
    "williamboman/mason-lspconfig.nvim", -- LSP config support for mason
    "neovim/nvim-lspconfig", -- LSP for neovim
  }
  use 'tami5/lspsaga.nvim'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  -- use 'github/copilot.vim'

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-vsnip',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind-nvim',
    },
  }

  use 'simrat39/symbols-outline.nvim' -- symbols
  use {
    'folke/trouble.nvim', -- Diagnostics view
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require('trouble').setup()
    end
  }

  -- Snippets
  use 'L3MON4D3/LuaSnip'
  use 'honza/vim-snippets'

  -- Debugging with dap
  use 'mfussenegger/nvim-dap'
  use 'leoluz/nvim-dap-go'
  use 'rcarriga/nvim-dap-ui'

  -- Eye candy
  use 'kyazdani42/nvim-web-devicons' -- Icons
  use 'junegunn/vim-emoji'

  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  }

  -- Themes
  use { 'catppuccin/nvim', as = 'catppuccin' }
  use 'rakr/vim-one' -- was rtp
  use 'marko-cerovac/material.nvim'
  use 'sainnhe/sonokai'
  use 'sainnhe/edge'
  use 'ray-x/aurora'
  use 'shaunsingh/moonlight.nvim'
  use 'sainnhe/everforest'
  use 'dracula/vim'
  use 'EdenEast/nightfox.nvim'
  use 'folke/tokyonight.nvim'
  use 'NLKNguyen/papercolor-theme'
  use 'tanvirtin/monokai.nvim'
  use 'drewtempelmeyer/palenight.vim'
  use 'sainnhe/gruvbox-material'
  use 'rose-pine/neovim'
  use 'navarasu/onedark.nvim'
  use 'RRethy/nvim-base16'
  use 'rebelot/kanagawa.nvim'
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup {
        -- for example, context is off by default, use this to turn it on
        show_current_context = true,
        show_current_context_start = true,
      }
    end
  }

  -- use 'liuchengxu/space-vim-theme'
  -- use 'sonph/onehalf', { 'rtp': 'vim' }
  -- use 'kyoz/purify', { 'rtp': 'vim' }
  --use 'crusoexia/vim-monokai'
  --use 'joshdick/onedark.vim'

  if PackerBootstrap then
    require('packer').sync()
  end
end)
