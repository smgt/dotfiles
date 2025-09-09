{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    baseIndex = 1;
    mouse = false;
    prefix = "C-a";
    aggressiveResize = true;
    clock24 = true;
    plugins = with pkgs; [
      # {
      #   plugin = tmux-catppuccin;
      #   extraConfig = ''
      #     set -g @catppuccin_flavor 'frappe'
      #     set -g @catppuccin_window_status_style "basic"
      #     set -g "@catppuccin_pane_default_text" "derp asdf"
      #     set -g @catppuccin_status_left_separator ""
      #     set -g "@catppuccin_host_icon" " 󰒋 "
      #     set -g "@catppuccin_session_icon" "  "
      #     set -g "@catppuccin_date_time_icon" " 󰃰 "
      #     set -g "@catppuccin_window_text" " #(pwd=\"#{pane_current_path}\"; echo $\{pwd####*/\})"
      #     set -g "@catppuccin_window_current_text" " #(pwd=\"#{pane_current_path}\"; echo $\{pwd####*/\})"
      #   '';
      # }
      tmuxPlugins.fzf-tmux-url
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.sensible
    ];
    extraConfig = ''
      # Allow passthrough codes for ESCAPE codes
      set -g allow-passthrough on
      # Set escape time to get rid of the lag in nvim when pressing ESC
      set -sg escape-time 0
      # Neovim
      set-option -g focus-events on

      # quick pane cycling
      unbind ^A
      bind ^A select-pane -t :.+

      # Sexy look
      # Add truecolor support
      set-option -ga terminal-overrides ",*256col*:Tc,wezterm:Tc,xterm-kitty:Tc"

      # Default terminal is 256 colors
      set -g default-terminal "tmux-256color"
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0

      # Set the current working directory based on the current pane's current
      # working directory (if set; if not, use the pane's starting directory)
      # when creating # new windows and splits.
      bind-key c new-window -c '#{pane_current_path}'
      bind-key '"' split-window -c '#{pane_current_path}'
      bind-key % split-window -h -c '#{pane_current_path}'

      # Open the new session in the current directory
      # bind-key S command-prompt "new-session -A -c '#{pane_current_path}' -s '%%'"

      set -g status-right-length 100
      set -g status-left-length 100
      #set -g status-left ""
      # set -g @tmux-gruvbox-right-status-x '%Y-%m-%d' # e.g.: 30.01.2024
      # set -g @tmux-gruvbox-right-status-z '#h #{tmux_mode_indicator}'
    '';
  };
}
