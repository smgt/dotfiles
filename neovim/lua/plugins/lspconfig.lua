-- Plugin for neovim development
require("neodev").setup()

local mason = require("mason-lspconfig")
mason.setup({
  ensure_installed = {
    "bashls",
    "bufls",
    "docker_compose_language_service",
    "dockerls",
    "golangci_lint_ls",
    "gopls",
    "jsonls",
    "jsonnet_ls",
    "lua_ls",
    "pyright",
    "rust_analyzer",
    "solargraph",
    "taplo",
    "terraformls",
    "tflint",
    "vimls",
    "yamlls",
  },
})

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "gj", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "gk", vim.diagnostic.goto_next, opts)
-- vim.keymap.set("n", "go", vim.diagnostic.setloclist, opts)
vim.keymap.set("n", "go", "<cmd>TroubleToggle<CR>", opts)
-- vim.keymap.set("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
-- vim.keymap.set("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  -- vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", bufopts)
  vim.keymap.set("n", "gD", "<cmd>Lspsaga peek_type_definition<CR>", bufopts)
  vim.keymap.set("n", "gr", "<cmd>Lspsaga finder<CR>", bufopts)
  vim.keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<CR>", bufopts)
  vim.keymap.set("n", "<Leader>o", "<cmd>Lspsaga outline<CR>", bufopts)
  -- vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  -- vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<space>rn", "<cmd>Lspsaga rename<CR>", bufopts)
  vim.keymap.set("n", "gx", "<cmd>Lspsaga code_action<CR>", bufopts)
  vim.keymap.set("n", "<space>f", function()
    vim.lsp.buf.format({ async = true, timeout_ms = 2000 })
  end, bufopts)

  -- Load completion
  -- require 'completion'.on_attach(client, bufnr)

  require("vim.lsp.protocol").CompletionItemKind = {
    "", -- Text
    "󰊕", -- Method
    "󰊕", -- Function
    "󰊕", -- Constructor
    "", -- Field
    "", -- Variable
    "", -- Class
    "󰜰", -- Interface
    "󰏗", -- Module
    "", -- Property
    "", -- Unit
    "󰎠", -- Value
    "", -- Enum
    "󰌋", -- Keyword
    "﬌", -- Snippet
    "", -- Color
    "", -- File
    "󰆑", -- Reference
    "", -- Folder
    "", -- EnumMember
    "", -- Constant
    "", -- Struct
    "", -- Event
    "󰘧", -- Operator
    "", -- TypeParameter
  }

  -- Custom diagnostic icons
  local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = "󰋽 " }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- Formatting on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_command([[augroup Format]])
    vim.api.nvim_command([[autocmd! * <buffer>]])
    vim.api.nvim_command(
      [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format({async = false, timeout_ms = 2000})]]
    )
    vim.api.nvim_command([[augroup END]])
  end
end

-- Enable cmp for each lsp server
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local custom_lsp_server_opts = {}

custom_lsp_server_opts.solargraph = {
  init_options = {
    autoformat = false,
  },
}

custom_lsp_server_opts.lua_ls = {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
        underline = true,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- prefix = "icons",
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
      -- Use neodev
      completion = {
        callSnippet = "Replace",
      },
    },
  },
}

custom_lsp_server_opts.gopls = {
  settings = {
    gopls = {
      gofumpt = true,
      buildFlags = { "-tags=integration" },
    },
  },
}

-- custom_lsp_server_opts.bufls = {
--   cmd = { "bufls", "serve", "--debug", "-v" },
-- }

custom_lsp_server_opts.yamlls = {
  settings = {
    yaml = {
      -- FIX mapKeyOrder warning
      keyOrdering = false,
    },
  },
}

local base_lsp_config = {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}

for _, server in ipairs(mason.get_installed_servers()) do
  local lsp_opts = vim.deepcopy(base_lsp_config)
  if custom_lsp_server_opts[server] then
    lsp_opts = vim.tbl_deep_extend("force", lsp_opts, custom_lsp_server_opts[server])
  end

  require("lspconfig")[server].setup(lsp_opts)
end
