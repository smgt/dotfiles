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

autocmd("BufWritePost", {
  pattern = "*",
  command = "lua require('lint').try_lint()",
})

local formatGroupID = augroup("FormatAutogroup", {})
autocmd("BufWritePost", { pattern = "*", command = "FormatWrite", group = formatGroupID })
