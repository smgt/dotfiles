local status, telescope = pcall(require, "telescope")
if (not status) then return end

local actions = require('telescope.actions')
telescope.setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--no-heading',
      '--with-filename',
      '--hidden',
      '--column',
      '--smart-case',
      '-g',
      '!.git/*'
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  },
  pickers = {
    find_files = {
      find_command = {'fd', '--type', 'file', '--follow', '--hidden', '--exclude', '.git'},
    }
  },
}


local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<Leader>p', '<cmd>Telescope find_files<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>l', '<cmd>Telescope live_grep<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>b', '<cmd>Telescope buffers<CR>', opts)
vim.api.nvim_set_keymap('n', ';;', '<cmd>Telescope help_tags<CR>', opts)

telescope.load_extension('fzy_native')
telescope.load_extension('dap')
