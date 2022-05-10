local status, null_ls = pcall(require, 'null-ls')
if (not status) then return end

-- local helpers = require("null-ls.helpers")

null_ls.setup({
  sources = {
    null_ls.builtins.completion.spell,
    null_ls.builtins.diagnostics.vale,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.diagnostics.hadolint,
    null_ls.builtins.diagnostics.jsonlint,
    null_ls.builtins.formatting.terraform_fmt,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.protolint,
    null_ls.builtins.diagnostics.teal,
    null_ls.builtins.diagnostics.vint,
    null_ls.builtins.diagnostics.golangci_lint
  },
})
