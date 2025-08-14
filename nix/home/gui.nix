{ config, pkgs, lib, ... }:
let mod = "Mod4";
in {
  imports = [
    ./wezterm.nix
    ./waybar.nix
    ./kanshi.nix
    ./thunderbird.nix
    ./syncthing.nix
    ./dunst.nix
  ];

  home = {
    # Make pointer a little bigger and set theme
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

  # Enable say
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

  services = {
    udiskie = {
      enable = true;
      tray = "always";
      automount = false;
    };

    blueman-applet.enable = true;

    network-manager-applet.enable = true;

    swayidle = let
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
}
