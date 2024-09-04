local status, null_ls = pcall(require, "null-ls")
if not status then
  require("notify")("Failed to initialize nullls (none-ls)", "error")
  return
end

null_ls.setup({
  sources = {
    -- null_ls.builtins.completion.spell,
    null_ls.builtins.diagnostics.vale,     -- prose
    null_ls.builtins.diagnostics.hadolint, -- Dockerfile
    null_ls.builtins.diagnostics.checkmake, -- makefile
    null_ls.builtins.diagnostics.teal,     -- Lua
    null_ls.builtins.diagnostics.vint,     -- Vimscript
    null_ls.builtins.diagnostics.buf,      -- buf
    null_ls.builtins.diagnostics.write_good, -- prose
    null_ls.builtins.diagnostics.golangci_lint.with({
      prefer_local = true
    }), -- Go
    -- null_ls.builtins.diagnostics.ruff,         -- python
    null_ls.builtins.formatting.terraform_fmt, --terraform
    null_ls.builtins.formatting.goimports.with({
      prefer_local = true
    }),   -- Go
    null_ls.builtins.formatting.gofumpt.with({
      prefer_local = true
    }),     -- Go
    null_ls.builtins.code_actions.impl,      -- Go
    null_ls.builtins.formatting.buf.with({
      prefer_local = true
    }),
    -- null_ls.builtins.formatting.protolint, -- proto
    null_ls.builtins.formatting.stylua, -- lua
    -- null_ls.builtins.diagnostics.standardrb,
  },
})

-- Automatically install all linters configured in null_ls
require("mason-null-ls").setup({
  ensure_installed = nil,
  automatic_installation = false,
  automatic_setup = false,
})
