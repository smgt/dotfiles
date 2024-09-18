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
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost packer_init.lua source <afile> | PackerSync
--   augroup end
-- ]])

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
  -- https://github.com/ray-x/guihua.lua
  use({
    "ray-x/guihua.lua",
    run = "cd lua/fzy && make",
  })

  -- Visualize coverage reports
  use({
    "andythigpen/nvim-coverage",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("coverage").setup()
    end,
  })
  -- File tree
  use("kyazdani42/nvim-tree.lua")
  use({
    "anuvyklack/windows.nvim", -- autoscale windows
    requires = "anuvyklack/middleclass",
    config = function()
      require("windows").setup()
    end,
  })

  use({
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end,
  })

  use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  })

  -- tmux
  use("benmills/vimux")
  use("christoomey/vim-tmux-navigator")

  -- telescope
  use({
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-lua/popup.nvim" },
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
  use("isobit/vim-caddyfile")
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

  use({
    "neovim/nvim-lspconfig",
    requires = {
      -- "williamboman/mason.nvim",            -- LSP installer
      -- "williamboman/mason-lspconfig.nvim",  -- LSP config support for mason, needs to be loaded before lspconfig
      { "j-hui/fidget.nvim", tag = "v1.4.5" }, -- LSP startup time status
      "folke/neodev.nvim",                  -- LSP annotations
    },
    config = function()
      require("fidget").setup()
    end,
  })

  use("nvimtools/none-ls.nvim") -- Linters etc
  -- use({
  --   -- "jayp0521/mason-null-ls.nvim",
  --   requires = {
  --     -- "williamboman/mason.nvim",
  --     "nvimtools/none-ls.nvim",
  --   },
  -- })

  use({
    "nvimdev/lspsaga.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("lspsaga").setup()
    end,
    requires = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  })

  -- auto-complete
  use({
    "hrsh7th/nvim-cmp",
    wants = { "LuaSnip" },
    requires = {
      "L3MON4D3/LuaSnip",
      "honza/vim-snippets",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-git",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",
    },
  })

  -- Debugging with dap
  use("mfussenegger/nvim-dap")
  use("leoluz/nvim-dap-go")
  use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } })
  -- use("jayp0521/mason-nvim-dap.nvim")

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

  -- use({
  -- 	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  -- 	config = function()
  -- 		require("lsp_lines").setup()
  -- 		vim.diagnostic.config({
  -- 			virtual_text = false,
  -- 		})
  -- 	end,
  -- })
  use({
    "felpafel/inlay-hint.nvim",
    requires = {
      { "nvim-treesitter/nvim-treesitter" },
    },
    config = function()
      require("inlay-hint").setup({
        display_callback = function(line_hints, options, bufnr)
          if options.virt_text_pos == "inline" then
            local lhint = {}
            for _, hint in pairs(line_hints) do
              local text = ""
              local label = hint.label
              if type(label) == "string" then
                text = label
              else
                for _, part in ipairs(label) do
                  text = text .. part.value
                end
              end
              if hint.paddingLeft then
                text = " " .. text
              end
              if hint.paddingRight then
                text = text .. " "
              end
              lhint[#lhint + 1] = { text = text, col = hint.position.character }
            end
            return lhint
          elseif options.virt_text_pos == "eol" or options.virt_text_pos == "right_align" then
            local k1 = {}
            local k2 = {}
            table.sort(line_hints, function(a, b)
              return a.position.character < b.position.character
            end)
            for _, hint in pairs(line_hints) do
              local label = hint.label
              local kind = hint.kind
              local node = kind == 1
                  and vim.treesitter.get_node({
                    bufnr = bufnr,
                    pos = {
                      hint.position.line,
                      hint.position.character - 1,
                    },
                  })
                  or nil
              local node_text = node and vim.treesitter.get_node_text(node, bufnr, {}) or ""
              local text = ""
              if type(label) == "string" then
                text = label
              else
                for _, part in ipairs(label) do
                  text = text .. part.value
                end
              end
              if kind == 1 then
                k1[#k1 + 1] = text:gsub(":%s*", node_text .. ": x")
              else
                k2[#k2 + 1] = text:gsub(":$", "y")
              end
            end
            local text = ""
            if #k2 > 0 then
              text = "<- (" .. table.concat(k2, ",") .. ")"
            end
            if #text > 0 then
              text = text .. " "
            end
            if #k1 > 0 then
              text = text .. "=> " .. table.concat(k1, ", ")
            end

            return text
          end
          return nil
        end,
      })
    end,
  })
  use({
    "folke/trouble.nvim", -- Diagnostics view
    requires = {
      "nvim-tree/nvim-web-devicons",
      "folke/lsp-colors.nvim",
    },
    config = function()
      require("trouble").setup()
    end,
  })
  use({
    "dgagn/diagflow.nvim",
    config = function()
      require("diagflow").setup({
        enable = true,
      })
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
  use({
    "akinsho/bufferline.nvim",
    tag = "*",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          diagnostic = "nvim_lsp",
          separator_style = "slant",
          underline = true,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              separator = "", -- use a "true" to enable the default, or set your own character
            },
          },
        },
      })
    end,
  })
  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup({
        debounce = 100,
        indent = { char = "▏" },
      })
    end,
  })
  -- use({
  --   "romgrk/barbar.nvim",
  --   requires = { "kyazdani42/nvim-web-devicons" },
  -- })
  -- use({ "glepnir/dashboard-nvim" })
  use({
    "goolord/alpha-nvim",
    config = function()
      require("alpha").setup(require("alpha.themes.dashboard").config)
    end,
  })

  -- Themes
  use({
    "catppuccin/nvim",
    as = "catppuccin",
    run = ":CatppuccinCompile",
    config = function()
      require("catppuccin").setup({
        flavour = "frappe",
        background = {
          light = "latte",
          dark = "frappe",
        },
      })
    end,
  })
  -- use("rakr/vim-one") -- was rtp
  -- use("marko-cerovac/material.nvim")
  use("sainnhe/sonokai")
  use("sainnhe/edge")
  use("ray-x/aurora")
  -- use("shaunsingh/moonlight.nvim")
  use("sainnhe/everforest")
  -- use("dracula/vim")
  use("EdenEast/nightfox.nvim")
  use("folke/tokyonight.nvim")
  use("NLKNguyen/papercolor-theme")
  use("tanvirtin/monokai.nvim")
  -- use("drewtempelmeyer/palenight.vim")
  -- use("sainnhe/gruvbox-material")
  use({ "rose-pine/neovim", as = "rose-pine" })
  -- use("navarasu/onedark.nvim")
  -- use("RRethy/nvim-base16")
  use({
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup()
    end,
  })
  use({ "nyoom-engineering/oxocarbon.nvim" })
  use("rebelot/kanagawa.nvim")

  -- use 'liuchengxu/space-vim-theme'
  -- use 'sonph/onehalf', { 'rtp': 'vim' }
  -- use 'kyoz/purify', { 'rtp': 'vim' }
  --use 'crusoexia/vim-monokai'
  --use 'joshdick/onedark.vim'

  if PackerBootstrap then
    require("packer").sync()
  end
end)
