{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.smgt;
  swayMod = "Mod4";
in
  with lib; {
    config = mkIf cfg.desktop.enable {
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
          modifier = swayMod;
          floating = {
            modifier = swayMod;
            border = 2;
          };
          keybindings = lib.mkOptionDefault {
            # "XF86MonBrightnessDown" = "exec light -G | cut -d'.' -f1 > $WOBSOCK";
            # "XF86MonBrightnessUp" = "exec light -G | cut -d'.' -f1 > $WOBSOCK";
            XF86AudioRaiseVolume = "exec 'pactl set-sink-volume @DEFAULT_SINK@ +1%'";
            XF86AudioLowerVolume = "exec 'pactl set-sink-volume @DEFAULT_SINK@ -1%'";
            XF86AudioMute = "exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'";
            "${swayMod}+Return" = "exec wezterm start --always-new-process";
            # "${mod}+Shift+Return" = "exec $HOME/.config/wofi/ssh.sh";
            "${swayMod}+Shift+q" = "kill";
            "${swayMod}+d" = "exec wofi --show drun --no-action";
            "${swayMod}+g" = "exec clipman pick -t wofi";
            "${swayMod}+h" = "focus left";
            "${swayMod}+j" = "focus down";
            "${swayMod}+k" = "focus up";
            "${swayMod}+l" = "focus right";
            "${swayMod}+Shift+j" = "move left";
            "${swayMod}+Shift+k" = "move down";
            "${swayMod}+Shift+l" = "move up";
            "${swayMod}+Shift+semicolon" = "move right";
            "${swayMod}+Shift+Left" = "move left";
            "${swayMod}+Shift+Down" = "move down";
            "${swayMod}+Shift+Up" = "move up";
            "${swayMod}+Shift+Right" = "move right";
            "${swayMod}+b" = "split h";
            "${swayMod}+v" = "split v";
            "${swayMod}+f" = "fullscreen toggle";
            "${swayMod}+s" = "layout stacking";
            "${swayMod}+w" = "layout tabbed";
            "${swayMod}+e" = "layout toggle split";
            "${swayMod}+Shift+space" = "floating toggle";
            "${swayMod}+space" = "focus mode_toggle";
            "${swayMod}+a" = "focus parent";
            #"${mod}+d" = "focus child";
            "${swayMod}+1" = "workspace 1";
            "${swayMod}+2" = "workspace 2";
            "${swayMod}+3" = "workspace 3";
            "${swayMod}+4" = "workspace 4";
            "${swayMod}+5" = "workspace 5";
            "${swayMod}+6" = "workspace 6";
            "${swayMod}+7" = "workspace 7";
            "${swayMod}+8" = "workspace 8";
            "${swayMod}+9" = "workspace 9";
            "${swayMod}+0" = "workspace 10";
            "${swayMod}+Shift+1" = "move container to workspace 1";
            "${swayMod}+Shift+2" = "move container to workspace 2";
            "${swayMod}+Shift+3" = "move container to workspace 3";
            "${swayMod}+Shift+4" = "move container to workspace 4";
            "${swayMod}+Shift+5" = "move container to workspace 5";
            "${swayMod}+Shift+6" = "move container to workspace 6";
            "${swayMod}+Shift+7" = "move container to workspace 7";
            "${swayMod}+Shift+8" = "move container to workspace 8";
            "${swayMod}+Shift+9" = "move container to workspace 9";
            "${swayMod}+Shift+0" = "move container to workspace 10";
            "${swayMod}+y" = "move workspace to output left";
            "${swayMod}+Shift+y" = "move container to output left";
            "${swayMod}+u" = "move workspace to output right";
            "${swayMod}+Shift+u" = "move container to output right";
            "${swayMod}+Shift+c" = "reload";
            "${swayMod}+Shift+r" = "restart";
            "${swayMod}+Ctrl+Shift+minus" = "move scratchpad";
            "${swayMod}+Ctrl+minus" = "scratchpad show";
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
            names = ["IosevkaTerm Nerd Font Mono"];
            size = 10.0;
          };
          bars = [{command = "${pkgs.waybar}/bin/waybar";}];
          startup = [
            {
              command = "${pkgs.sway}/bin/swaymsg workspace 3; ${pkgs._1password-gui}/bin/1password";
            }
            {
              command = "${pkgs.sway}/bin/swaymsg workspace 2; ${pkgs.wezterm}/bin/wezterm start --always-new-process";
            }
            {
              command = "${pkgs.sway}/bin/swaymsg workspace 1; ${pkgs.firefox}/bin/firefox";
            }
          ];
          assigns = {
            "1" = [{app_id = "firefox";}];
            "3" = [
              # { class = "^1Password$"; }
              {app_id = "org.pulseaudio.pavucontrol";}
            ];
            "4" = [{class = "^MongoDB Compass$";}];
            "8" = [
              {
                app_id = "com.slack.Slack";
              }
              {class = "^discord$";}
            ];
            "9" = [{app_id = "spotify";}];
          };
        };
      };
      programs.swaylock = {
        enable = true;
        settings = {
          color = "1e1e2e";
          font = "sans-serif";
        };
      };
      services = {
        swayidle = let
          lockNow = "${pkgs.swaylock}/bin/swaylock -fF";
          suspendNow = "${config.systemd.user.systemctlPath} suspend";
          isOnBattery = pkgs.writeShellScript "is-on-battery" ''
            [ $(cat /sys/class/power_supply/dc-charger/online) = "0" ] || exit 1
          '';
        in {
          enable = true;
          timeouts = [
            {
              timeout = 4 * 60;
              command = "${isOnBattery} && ${lockNow}";
            }
            {
              timeout = 8 * 60;
              command = "${lockNow}";
            }
            {
              timeout = 10 * 60;
              command = ''${pkgs.sway}/bin/swaymsg "output * dpms off"'';
              resumeCommand = ''${pkgs.sway}/bin/swaymsg "output * dpms on"'';
            }
            {
              timeout = 60 * 60;
              command = "${suspendNow}";
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
      systemd.user.services.swaybg = {
        Unit = {
          Description = "swaybg background service";
          Documentation = "man:swaybg(1)";
          PartOf = ["graphical-session.target"];
        };
        Service = {
          ExecStart = "${pkgs.swaybg}/bin/swaybg -c #292c3c";
          Type = "simple";
        };
        Install.WantedBy = ["sway-session.target"];
      };
    };
  }
