-- Automatically install packer
PackerBootstrap = false
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	PackerBootstrap = true
	fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.o.runtimepath = vim.fn.stdpath("data") .. "/site/pack/*/start/*," .. vim.o.runtimepath
end

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer_init.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Install plugins
return packer.startup(function(use)
	-- packer manages packer
	use({ "wbthomason/packer.nvim" })

	-- utils
	use("tpope/vim-surround")
	use("tpope/vim-unimpaired")
	use("tpope/vim-commentary") -- comments
	use("JoosepAlviste/nvim-ts-context-commentstring") -- context aware comment-string
	use({
		"ray-x/guihua.lua",
		run = "cd lua/fzy && make",
	})
	use("kyazdani42/nvim-tree.lua")
	use({
		"anuvyklack/windows.nvim", -- autoscale windows
		requires = "anuvyklack/middleclass",
		config = function()
			require("windows").setup()
		end,
	})
	use({
		"krivahtoo/silicon.nvim",
		run = "./install.sh",
		config = function()
			require("silicon").setup({
				theme = "gruvbox",
				font = "Iosevka Term Curly=16",
			})
		end,
	})

	-- git
	use("gregsexton/gitv")
	use({
		"tpope/vim-fugitive",
		requires = {
			{ "tpope/vim-rhubarb" },
		},
	})

	-- tmux
	use("benmills/vimux")
	use("christoomey/vim-tmux-navigator")

	-- telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzy-native.nvim" },
			{ "nvim-telescope/telescope-symbols.nvim" },
			{ "nvim-telescope/telescope-dap.nvim" },
		},
	})

	-- Statusline
	use("hoob3rt/lualine.nvim")

	-- Language support
	use("vim-crystal/vim-crystal")
	use("PyGamer0/vim-apl")
	use("baruchel/vim-notebook")
	use("hashivim/vim-terraform")
	use("ellisonleao/glow.nvim") -- markdown preview
	-- use {
	--   'ray-x/go.nvim',
	--   config = function()
	--     require('go').setup()
	--   end
	-- }

	use({
		"edolphin-ydf/goimpl.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-lua/popup.nvim" },
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			require("telescope").load_extension("goimpl")
		end,
	})

	-- LSP + treesitter plugins
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	use("williamboman/mason.nvim") -- LSP installer
	use("williamboman/mason-lspconfig.nvim") -- LSP config support for mason, needs to be loaded before lspconfig

	use("neovim/nvim-lspconfig")

	use("jose-elias-alvarez/null-ls.nvim") -- Linters etc
	use("jayp0521/mason-null-ls.nvim") -- NOTE: needs to be loaded after null-ls

	use("glepnir/lspsaga.nvim")

	use({
		"zbirenbaum/copilot.lua",
		event = { "VimEnter" },
		config = function()
			vim.defer_fn(function()
				require("copilot").setup()
			end, 100)
		end,
	})

	-- auto-complete
	use({
		"hrsh7th/nvim-cmp",
		wants = { "LuaSnip", "copilot" },
		requires = {
			"L3MON4D3/LuaSnip",
			"honza/vim-snippets",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind-nvim",
			"zbirenbaum/copilot-cmp",
		},
	})

	-- Debugging with dap
	use("mfussenegger/nvim-dap")
	use("leoluz/nvim-dap-go")
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })

	-- Eye candy

	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	use({
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
			vim.diagnostic.config({
				virtual_text = false,
			})
		end,
	})
	use({
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup()
		end,
	})
	use({
		"folke/trouble.nvim", -- Diagnostics view
		requires = {
			"kyazdani42/nvim-web-devicons",
			"folke/lsp-colors.nvim",
		},
		config = function()
			require("trouble").setup()
		end,
	})
	use("kyazdani42/nvim-web-devicons") -- Icons
	use("junegunn/vim-emoji")
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})
	-- use {
	--   'akinsho/bufferline.nvim',
	--   tag = "v2.*",
	--   requires = 'kyazdani42/nvim-web-devicons',
	--   config = function()
	--     require("bufferline").setup({
	--     })
	--   end
	-- }
	use({
		"romgrk/barbar.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	})
	-- use({ "glepnir/dashboard-nvim" })
	use({
		"goolord/alpha-nvim",
		config = function()
			require("alpha").setup(require("alpha.themes.dashboard").config)
		end,
	})

	-- Themes
	use({ "catppuccin/nvim", as = "catppuccin", run = ":CatppuccinCompile" })
	use("rakr/vim-one") -- was rtp
	use("marko-cerovac/material.nvim")
	use("sainnhe/sonokai")
	use("sainnhe/edge")
	use("ray-x/aurora")
	use("shaunsingh/moonlight.nvim")
	use("sainnhe/everforest")
	use("dracula/vim")
	use("EdenEast/nightfox.nvim")
	use("folke/tokyonight.nvim")
	use("NLKNguyen/papercolor-theme")
	use("tanvirtin/monokai.nvim")
	use("drewtempelmeyer/palenight.vim")
	use("sainnhe/gruvbox-material")
	use("rose-pine/neovim")
	use("navarasu/onedark.nvim")
	use("RRethy/nvim-base16")
	use("rebelot/kanagawa.nvim")
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				-- for example, context is off by default, use this to turn it on
				show_current_context = true,
				show_current_context_start = true,
			})
		end,
	})

	-- use 'liuchengxu/space-vim-theme'
	-- use 'sonph/onehalf', { 'rtp': 'vim' }
	-- use 'kyoz/purify', { 'rtp': 'vim' }
	--use 'crusoexia/vim-monokai'
	--use 'joshdick/onedark.vim'

	if PackerBootstrap then
		require("packer").sync()
	end
end)
