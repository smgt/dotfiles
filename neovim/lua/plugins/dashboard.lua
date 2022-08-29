local dashboard_custom_header = {
  ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
  ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
  ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
  ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
  ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
  ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
}
local home = os.getenv('HOME')
local db = require('dashboard')
db.custom_header = dashboard_custom_header
db.custom_center = {
  { icon = ' ',
    desc = 'Find File            ',
    action = 'Telescope find_files',
    shortcut = ',p'
  },
  { icon = ' ',
    desc = 'File Browser           ',
    action = 'NvimTreeOpen',
  },
  {
    icon = ' ',
    desc = 'Find word            ',
    action = 'Telescope live_grep',
    shortcut = ',l'
  },
  {
    icon = ' ',
    desc = 'Open dotfiles         ',
    action = 'Telescope dotfiles path=' .. home .. '/.dotfiles',
  },
}
