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

telescope.load_extension('fzy_native')
telescope.load_extension('dap')
