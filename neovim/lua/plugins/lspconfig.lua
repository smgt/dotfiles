require("mason").setup()
local mason = require("mason-lspconfig")
mason.setup({
  ensure_installed = {
    "bashls",
    "dockerls",
    "gopls",
    "jsonls",
    "jsonnet_ls",
    "pyright",
    "golangci-lint",
    "golangci-lint-langserver",
    "rust_analyzer",
    "solargraph",
    "sumneko_lua",
    "taplo",
    "terraformls",
    "tflint",
    "vimls",
    "yamlls",
    "vale",
    "impl",
  }
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap("n", "<space>rn", "<cmd>Lspsaga rename<cr>", opts)
  -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap("n", "gx", "<cmd>Lspsaga code_action<cr>", opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  -- buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
  -- buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap("n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  buf_set_keymap("x", "gx", ":<c-u>Lspsaga range_code_action<cr>", opts)
  buf_set_keymap("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>", opts)
  buf_set_keymap("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>", opts)

  -- Load completion
  -- require 'completion'.on_attach(client, bufnr)

  require('vim.lsp.protocol').CompletionItemKind = {
    '', -- Text
    '', -- Method
    '', -- Function
    '', -- Constructor
    '', -- Field
    '', -- Variable
    '', -- Class
    'ﰮ', -- Interface
    '', -- Module
    '', -- Property
    '', -- Unit
    '', -- Value
    '', -- Enum
    '', -- Keyword
    '﬌', -- Snippet
    '', -- Color
    '', -- File
    '', -- Reference
    '', -- Folder
    '', -- EnumMember
    '', -- Constant
    '', -- Struct
    '', -- Event
    'ﬦ', -- Operator
    '', -- TypeParameter
  }

  -- Custom diagnostic icons
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- Formatting on save
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    vim.api.nvim_command [[augroup END]]
  end
end

-- Enable cmp for each lsp server
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local custom_lsp_server_opts = {}

custom_lsp_server_opts.solargraph = {
  init_options = {
    formatting = false
  }
}

custom_lsp_server_opts.sumneko_lua = {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    }
  }
}

local base_lsp_config = {
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
}

for _, server in ipairs(mason.get_installed_servers()) do
  local opts = vim.deepcopy(base_lsp_config)
  if custom_lsp_server_opts[server] then
    opts = vim.tbl_deep_extend('force', opts, custom_lsp_server_opts[server])
  end

  require('lspconfig')[server].setup(opts)
end

---- Register a handler that will be called for all installed servers.
--lsp_installer.on_server_ready(function(server)
--  local opts = {
--    capabilities = capabilities,
--    on_attach = on_attach,
--    flags = {
--      debounce_text_changes = 150,
--    },
--  }

--  if custom_server_opts[server.name] then
--    custom_server_opts[server.name](opts)
--  end

--  -- This setup() function is exactly the same as lspconfig's setup function.
--  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--  server:setup(opts)
--end)

---- Setup lspconfig.
---- Use a loop to conveniently call 'setup' on multiple servers and
---- map buffer local keybindings when the language server attaches
----[[ nvim_lsp['gopls'].setup {
--  capabilities = capabilities,
--  on_attach = on_attach,
--  flags = {
--    debounce_text_changes = 150,
--  },
--  settings = {
--    gopls = {
--      buildFlags = {"-tags=integration"}
--    }
--  }
--} ]]
