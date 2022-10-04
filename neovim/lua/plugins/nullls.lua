local status, null_ls = pcall(require, 'null-ls')
if (not status) then return end

null_ls.setup({
  sources = {
    -- null_ls.builtins.completion.spell,
    null_ls.builtins.diagnostics.vale, -- prose
    null_ls.builtins.diagnostics.shellcheck, -- shell
    null_ls.builtins.diagnostics.hadolint, -- Dockerfile
    null_ls.builtins.diagnostics.jsonlint, -- JSON
    null_ls.builtins.diagnostics.checkmake, -- makefile
    null_ls.builtins.diagnostics.teal, -- Lua
    null_ls.builtins.diagnostics.vint, -- Vimscript
    null_ls.builtins.diagnostics.write_good, -- prose
    null_ls.builtins.formatting.terraform_fmt, --terraform
    null_ls.builtins.formatting.goimports, -- Go
    null_ls.builtins.formatting.protolint, -- proto
  },
})

require("mason-null-ls").setup()
