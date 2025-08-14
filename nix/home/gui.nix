{ config, pkgs, lib, ... }:
let mod = "Mod4";
in {
  imports = [
    ./wezterm.nix
    ./waybar.nix
    ./kanshi.nix
    ./thunderbird.nix
    ./syncthing.nix
  ];
  home = {
    pointerCursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
      x11 = {
        enable = true;
        defaultCursor = "Adwaita";
      };
      sway.enable = true;
    };
  };
  wayland.windowManager.sway = {
    enable = true;
    package = null;
    systemd.variables = [
      "PATH"
      "DISPLAY"
      "WAYLAND_DISPLAY"
      "SWAYSOCK"
      "XDG_CURRENT_DESKTOP"
      "XDG_SESSION_TYPE"
      "NIXOS_OZONE_WL"
      "XCURSOR_THEME"
      "XCURSOR_SIZE"
    ];
    config = {
      window = {
        hideEdgeBorders = "none";
        titlebar = false;
        border = 2;
      };
      modifier = mod;
      floating = {
        modifier = mod;
        border = 2;
      };
      keybindings = lib.mkOptionDefault {
        # "XF86MonBrightnessDown" = "exec light -G | cut -d'.' -f1 > $WOBSOCK";
        # "XF86MonBrightnessUp" = "exec light -G | cut -d'.' -f1 > $WOBSOCK";
        XF86AudioRaiseVolume =
          "exec 'pactl set-sink-volume @DEFAULT_SINK@ +1%'";
        XF86AudioLowerVolume =
          "exec 'pactl set-sink-volume @DEFAULT_SINK@ -1%'";
        XF86AudioMute = "exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'";
        "${mod}+Return" = "exec wezterm start --always-new-process";
        # "${mod}+Shift+Return" = "exec $HOME/.config/wofi/ssh.sh";
        "${mod}+Shift+q" = "kill";
        "${mod}+d" = "exec wofi --show drun --no-action";
        # "${mod}+g" = "exec clipman pick -t wofi";
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";
        "${mod}+Shift+j" = "move left";
        "${mod}+Shift+k" = "move down";
        "${mod}+Shift+l" = "move up";
        "${mod}+Shift+semicolon" = "move right";
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";
        "${mod}+b" = "split h";
        "${mod}+v" = "split v";
        "${mod}+f" = "fullscreen toggle";
        "${mod}+s" = "layout stacking";
        "${mod}+w" = "layout tabbed";
        "${mod}+e" = "layout toggle split";
        "${mod}+Shift+space" = "floating toggle";
        "${mod}+space" = "focus mode_toggle";
        "${mod}+a" = "focus parent";
        #"${mod}+d" = "focus child";
        "${mod}+1" = "workspace 1";
        "${mod}+2" = "workspace 2";
        "${mod}+3" = "workspace 3";
        "${mod}+4" = "workspace 4";
        "${mod}+5" = "workspace 5";
        "${mod}+6" = "workspace 6";
        "${mod}+7" = "workspace 7";
        "${mod}+8" = "workspace 8";
        "${mod}+9" = "workspace 9";
        "${mod}+0" = "workspace 10";
        "${mod}+Shift+1" = "move container to workspace 1";
        "${mod}+Shift+2" = "move container to workspace 2";
        "${mod}+Shift+3" = "move container to workspace 3";
        "${mod}+Shift+4" = "move container to workspace 4";
        "${mod}+Shift+5" = "move container to workspace 5";
        "${mod}+Shift+6" = "move container to workspace 6";
        "${mod}+Shift+7" = "move container to workspace 7";
        "${mod}+Shift+8" = "move container to workspace 8";
        "${mod}+Shift+9" = "move container to workspace 9";
        "${mod}+Shift+0" = "move container to workspace 10";
        "${mod}+y" = "move workspace to output left";
        "${mod}+Shift+y" = "move container to output left";
        "${mod}+u" = "move workspace to output right";
        "${mod}+Shift+u" = "move container to output right";
        "${mod}+Shift+c" = "reload";
        "${mod}+Shift+r" = "restart";
        "${mod}+Ctrl+Shift+minus" = "move scratchpad";
        "${mod}+Ctrl+minus" = "scratchpad show";
      };
      input = {
        "type:keyboard" = {
          xkb_layout = "us,se";
          xkb_variant = ",nodeadkeys";
          xkb_options = "grp:alt_shift_toggle";
        };
        "type:touchpad" = {
          natural_scroll = "disabled";
          scroll_factor = "0.6";
        };
      };
      modes = {
        resize = {
          Return = "mode default";
          Escape = "mode default";
          h = "resize shrink width 10 px or 10 ppt";
          j = "resize grow height 10 px or 10 ppt";
          k = "resize shrink height 10 px or 10 ppt";
          l = "resize grow width 10 px or 10 ppt";
        };
      };
      terminal = "wezterm";
      fonts = {
        names = [ "IosevkaTerm Nerd Font Mono" ];
        size = 10.0;
      };
      bars = [{ command = "${pkgs.waybar}/bin/waybar"; }];
      startup = [
        {
          command =
            "${pkgs.sway}/bin/swaymsg workspace 3 && ${pkgs._1password-gui}/bin/1password";
        }
        {
          command =
            "${pkgs.sway}/bin/swaymsg workspace 2 && ${pkgs.wezterm}/bin/wezterm start --always-new-process";
        }
        {
          command =
            "${pkgs.sway}/bin/swaymsg workspace 1 && ${pkgs.firefox}/bin/firefox";
        }
      ];
      assigns = {
        "1" = [{ app_id = "firefox"; }];
        "3" = [
          # { class = "^1Password$"; }
          { app_id = "org.pulseaudio.pavucontrol"; }
        ];
        "4" = [{ class = "^MongoDB Compass$"; }];
        "8" = [ { class = "^Slack$"; } { class = "^discord$"; } ];
        "9" = [{ class = "^Spotify$"; }];
      };
    };
  };

  services.udiskie = {
    enable = true;
    tray = "always";
    automount = false;
  };

  services.blueman-applet.enable = true;
  services.network-manager-applet.enable = true;

  services.swayidle = let
    lockNow = "${pkgs.swaylock}/bin/swaylock -f";
    # suspendNow = "${config.systemd.user.systemctlPath} suspend";
    isOnBattery = pkgs.writeShellScript "is-on-battery" ''
      [ $(cat /sys/class/power_supply/dc-charger/online) = "0" ] || exit 1
    '';
  in {
    enable = true;
    timeouts = [
      {
        timeout = 5 * 60;
        command = "${isOnBattery} && ${lockNow}";
      }
      {
        timeout = 15 * 60;
        command = "${lockNow}";
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = "${lockNow}";
      }
      {
        event = "lock";
        command = "${lockNow}";
      }
    ];
  };

  programs.swaylock = {
    enable = true;
    settings = {
      color = "1e1e2e";
      font = "sans-serif";
    };
  };

  systemd.user.services.swaybg = {
    Unit = {
      Description = "swaybg background service";
      Documentation = "man:swaybg(1)";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.swaybg}/bin/swaybg -c #292c3c";
      Type = "simple";
    };
    Install.WantedBy = [ "sway-session.target" ];
  };
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
        format =
          "<span foreground='#949498' size='smaller'>%a</span>\\n<b>%s</b>\\n<span>%b</span>";
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
}
