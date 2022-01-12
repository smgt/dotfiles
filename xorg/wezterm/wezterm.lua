local wezterm = require 'wezterm';
return {
  font = wezterm.font("JetBrainsMono Nerd Font"),
  font_size = 12.0,
  enable_tab_bar = false,
  color_scheme_dirs = {"$HOME/.config/wezterm/colors"},
  color_scheme = "papercolor-light",
  

  ssh_domains = {
    {
      name = "grunte",
      remote_address = "grunte",
    }
  },
}
