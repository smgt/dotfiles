local status, null_ls = pcall(require, "null-ls")
if not status then
	require("notify")("Failed to initialize nullls (none-ls)", "error")
	return
end

null_ls.setup({
	sources = {
		null_ls.builtins.diagnostics.vale, -- prose
		null_ls.builtins.diagnostics.hadolint, -- Dockerfile
		null_ls.builtins.diagnostics.checkmake, -- makefile
		null_ls.builtins.diagnostics.vint, -- Vimscript
		null_ls.builtins.diagnostics.buf, -- buf
		null_ls.builtins.diagnostics.write_good, -- prose
		null_ls.builtins.diagnostics.golangci_lint, -- Go
		null_ls.builtins.diagnostics.statix, -- nix
		null_ls.builtins.formatting.terraform_fmt, --terraform
		null_ls.builtins.formatting.hclfmt, -- HCL
		null_ls.builtins.formatting.goimports, -- Go
		null_ls.builtins.formatting.gofumpt, -- Go
		null_ls.builtins.formatting.buf, -- protobuf
		null_ls.builtins.formatting.stylua, -- lua
		null_ls.builtins.formatting.nixfmt, -- nix
		null_ls.builtins.code_actions.impl, -- Go
		null_ls.builtins.code_actions.statix, -- nix
	},
})
