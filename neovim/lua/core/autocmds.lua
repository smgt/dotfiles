local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- autocmd('BufReadPost', {
--   pattern = '*',
--   command = 'if line("\'\"") > 0 && line("\'\"") <= line("$")| exe "normal g\'\"" | endif',
-- })

autocmd("BufRead", {
  pattern = "/tmp/mutt-*",
  command = "set tw=72",
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "{Guardfile, vagrantfile, Vagrantfile, Gemfile, Rakefile, Thorfile, config.ru}",
  command = "set ft=ruby",
})

autocmd("FileType", {
  pattern = "make",
  command = "set noexpandtab",
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.cr",
  command = "set ft=crystal",
})

autocmd({ "BufRead", "BufNewFile" }, { pattern = { "*.txt", "*.md", "gitcommit" }, command = "setlocal spell" })

-- start git commit messages in insert mode
augroup("bufcheck", { clear = true })
autocmd("FileType", {
  group = "bufcheck",
  pattern = { "gitcommit", "gitrebase" },
  command = "startinsert | 1",
})

-- autocmd("LspAttach", {
--   group = vim.api.nvim_create_augroup("UserLspConfig", {}),
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if client.server_capabilities.inlayHintProvider then
--       vim.lsp.inlay_hint.enable(true)
--     end
--   end,
-- })

autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf ---@type number
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.supports_method('textDocument/inlayHint') then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      vim.keymap.set('n', '<leader>i', function()
        vim.lsp.inlay_hint.enable(
          not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
          { bufnr = bufnr }
        )
      end, { buffer = bufnr })
    end
  end,
})

-- autocmd("BufWritePost", {
--   pattern = "*",
--   callback = function()
--     require("lint").try_lint()
--   end,
-- })

-- local formatGroupID = augroup("FormatAutogroup", {})
-- autocmd("BufWritePost", {
--   pattern = "*",
--   command = "FormatWrite",
--   group = formatGroupID
-- })
