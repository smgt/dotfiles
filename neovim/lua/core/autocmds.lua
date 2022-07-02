local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- autocmd('BufReadPost', {
--   pattern = '*',
--   command = 'if line("\'\"") > 0 && line("\'\"") <= line("$")| exe "normal g\'\"" | endif',
-- })

autocmd('BufRead', {
  pattern = '/tmp/mutt-*',
  command = 'set tw=72',
})

autocmd('BufRead,BufNewFile', {
  pattern = '{Guardfile, vagrantfile, Vagrantfile, Gemfile, Rakefile, Thorfile, config.ru}',
  command = 'set ft=ruby',
})

autocmd('FileType', {
  pattern = 'make',
  command = 'set noexpandtab',
})

autocmd('BufRead,BufNewFile', {
  pattern = '*.cr',
  command = 'set ft=crystal',
})
