{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.smgt;
in
  with lib; {
    config = mkIf cfg.desktop.enable {
      services.dunst = {
        enable = true;
        iconTheme = {
          package = pkgs.adwaita-icon-theme;
          name = "Adwaita";
        };
        settings = {
          global = {
            font = "IosevkaTerm Nerd Font Mono";
            markup = "yes";
            format = "<span foreground='#949498' size='smaller'>%a</span>\\n<b>%s</b>\\n<span>%b</span>";
            sort = "no";
            indicate_hidden = "yes";
            # alignment = "right";
            #bounce_freq = 0;
            show_age_threshold = -1;
            word_wrap = "yes";
            ignore_newline = "no";
            stack_duplicates = "no";
            width = 450;
            height = 100;
            offset = "-0+39";
            origin = "top-right";
            shrink = "no";
            transparency = 0;
            idle_threshold = 0;
            monitor = 0;
            follow = "none";
            sticky_history = "yes";
            history_length = 15;
            show_indicators = "yes";
            line_height = 3;
            separator_height = 2;
            padding = 6;
            horizontal_padding = 6;
            dmenu = "${pkgs.rofi}/bin/rofi -show drun:";
            browser = "${pkgs.firefox}/bin/firefox -new-tab";
            enable_recursive_icon_lookup = true;
            icon_position = "left";
            max_icon_size = 50;
            icon_theme = "Adwaita";
            frame_width = 2;
            frame_color = "#8caaee";
            separator_color = "frame";
            highlight = "#8caaee";
          };
          urgency_low = {
            background = "#303446";
            foreground = "#c6d0f5";
          };
          urgency_normal = {
            background = "#303446";
            foreground = "#c6d0f5";
          };
          urgency_critical = {
            background = "#303446";
            foreground = "#c6d0f5";
            frame_color = "#ef9f76";
          };
          # shortcuts = {
          #   close = "ctrl+space";
          #   close_all = "ctrl+shift+space";
          #   history = "ctrl+grave";
          #   context = "ctrl+shift+period";
          # };
        };
      };
    };
  }
