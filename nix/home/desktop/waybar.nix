{
  config,
  lib,
  ...
}: let
  cfg = config.smgt;
in
  with lib; {
    config = mkIf cfg.desktop.enable {
      programs.waybar = {
        enable = true;
        settings = [
          {
            #  "layer": "top", // Waybar at top layer
            #  "position": "bottom", // Waybar position (top|bottom|left|right)
            height = 30; # Waybar height (to be removed for auto height)
            # width = 1280; # Waybar width
            spacing = 4; # Gaps between modules (4px)
            # Choose the order of the modules
            modules-left = [
              "sway/workspaces"
              "sway/mode"
              # "sway/scratchpad",
              # "custom/media"
            ];
            modules-center = [
              #"sway/window"
              "clock"
            ];
            modules-right = [
              "pulseaudio"
              # "network"
              # "cpu"
              "memory"
              "temperature"
              # "backlight"
              # "keyboard-state"
              "sway/language"
              "battery"
              # "custom/unread"
              "idle_inhibitor"
              "custom/screenshot"
              "custom/darkman"
              # "mpris"
              "custom/lock"
              "custom/sleep"
              "tray"
            ];
            # Modules configuration
            "sway/workspaces" = {
              disable-scroll = true;
              all-outputs = false;
              # "format = "{name }: {icon }",
              format = "{name}";
              format-icons = {
                "1" = "";
                "2" = "";
                "3" = "";
                "4" = "";
                "5" = "";
                urgent = "";
                focused = "";
                default = "";
              };
            };

            keyboard-state = {
              numlock = true;
              capslock = true;
              format = "{name} {icon}";
              format-icons = {
                locked = "";
                unlocked = "";
              };
            };

            "sway/mode" = {
              format = ''<span style=\"italic\">{}</span>'';
            };

            "sway/scratchpad" = {
              format = "{icon} {count}";
              show-empty = false;
              format-icons = [
                ""
                ""
              ];
              tooltip = true;
              tooltip-format = "{app}: {title}";
            };

            mpd = {
              format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
              format-disconnected = "Disconnected ";
              format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
              unknown-tag = "N/A";
              interval = 2;
              consume-icons = {
                on = " ";
              };
              random-icons = {
                off = "<span color=\"#f53c3c\"></span> ";
                on = " ";
              };
              repeat-icons = {
                on = " ";
              };
              single-icons = {
                on = "1 ";
              };
              state-icons = {
                paused = "";
                playing = "";
              };
              tooltip-format = "MPD (connected)";
              tooltip-format-disconnected = "MPD (disconnected)";
            };

            idle_inhibitor = {
              format = "{icon}";
              format-icons = {
                activated = "";
                deactivated = "";
              };
            };

            tray = {
              # "icon-size = 21,
              spacing = 10;
            };

            clock = {
              timezone = "Europe/Stockholm";
              format = "{:%H:%M %Y-%m-%d W%W}";
              format-alt = "{:%A %B %d, %Y (%R)}  ";
              tooltip-format = "<tt><small>{calendar}</small></tt>";
              calendar = {
                mode = "year";
                mode-mon-col = 3;
                weeks-pos = "right";
                on-scroll = 1;
                on-click-right = "mode";
                format = {
                  months = "<span color='#ffead3'><b>{}</b></span>";
                  days = "<span color='#ecc6d9'><b>{}</b></span>";
                  weeks = "<span color='#99ffdd'><b>W{}</b></span>";
                  weekdays = "<span color='#ffcc66'><b>{}</b></span>";
                  today = "<span color='#ff6699'><b><u>{}</u></b></span>";
                };
              };
            };

            cpu = {
              format = "{usage}% ";
              tooltip = false;
            };

            memory = {
              format = " {}%";
            };

            temperature = {
              # "thermal-zone = 2,
              # "hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input",
              critical-threshold = 80;
              # format-critical = "{temperatureC }°C {icon }",
              format = "{temperatureC}°C {icon}";
              format-icons = [
                ""
                ""
                ""
              ];
            };

            backlight = {
              device = "intel_backlight";
              format = "{percent}% {icon}";
              format-icons = [
                ""
                ""
                ""
                ""
                ""
                ""
                ""
                ""
                ""
              ];
              on-click = "light -A 10";
            };

            battery = {
              states = {
                # "good = 95;
                warning = 30;
                critical = 15;
              };
              format = "{capacity}% {icon}";
              format-charging = "{capacity}% ";
              format-plugged = "{capacity}% ";
              format-alt = "{time} {icon}";
              # format-good = ""; // An empty format will hide the module
              # format-full = "";
              format-icons = [
                ""
                ""
                ""
                ""
                ""
              ];
            };

            network = {
              # "interface = "wlp2*", // (Optional) To force the use of this interface
              format-wifi = "{essid} ({signalStrength}%) ";
              format-ethernet = "{ipaddr}/{cidr} ";
              tooltip-format = "{ifname} via {gwaddr} ";
              format-linked = "{ifname} (No IP) ";
              format-disconnected = "Disconnected ⚠";
              format-alt = "{ifname}: {ipaddr}/{cidr}";
            };

            pulseaudio = {
              # "scroll-step = 1; // %, can be a float
              format = "{icon} {volume}% {format_source}";
              format-bluetooth = "{volume}% {icon} {format_source}";
              format-bluetooth-muted = " {icon} {format_source}";
              format-muted = "{format_source}";
              format-source = " {volume}%";
              format-source-muted = "";
              format-icons = {
                headphone = "";
                hands-free = "";
                headset = "";
                phone = "";
                portable = "";
                car = "";
                default = [
                  ""
                  ""
                  ""
                ];
              };
              on-click = "pavucontrol";
            };

            "custom/media" = {
              format = "{icon} {}";
              return-type = "json";
              max-length = 40;
              format-icons = {
                spotify = "";
                default = "🎜";
              };
              escape = true;
              exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null"; # Script in resources folder
              # "exec = "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null" // Filter player based on name
            };

            "custom/screenshot" = {
              format = "";
              # "on-click = "wayshot -s \"$(slurp -f '%x %y %w %h')\"";
              on-click = "grim -g \"$(slurp)\" - | wl-copy -t image/png";
              interval = "once";
            };

            "custom/music" = {
              format = "";
              on-click = "playerctl play-pause";
              tooltip = true;
              interval = "once";
            };

            "custom/darkman" = {
              format = "{icon}";
              on-click = "darkman toggle";
              return-type = "json";
              exec = "sleep 0.2;DM=$(darkman get | tr -d '\n'); echo '{\"alt\": \"'$DM'\", \"text\":\"darkmode\", \"tooltip\":\"'$DM'\"}'";
              format-icons = {
                dark = " dark";
                light = " light";
              };
              exec-on-event = true;
              tooltip = true;
              interval = "once";
            };

            "custom/lock" = {
              format = " lock";
              exec = "echo '\nlock screen'";
              #exec-on-event = true;
              on-click = "sleep 0.117;loginctl lock-session";
              # on-click = "notify-send dep";
              tooltip = true;
              interval = "once";
              max-length = 40;
            };

            "custom/sleep" = {
              format = "󰒲  sleep";
              #exec-on-event = true;
              on-click = "sleep 3;systemctl sleep";
              # on-click = "notify-send dep";
              tooltip = true;
              interval = "once";
              max-length = 40;
            };

            "sway/language" = {
              format = " {}";
              on-click = "swaymsg input type:keyboard xkb_switch_layout next";
              tooltip-format = "{long}";
            };

            mpris = {
              # format = "{player_icon} {status_icon}";
              format-paused = "{player_icon} {status_icon}";
              player-icons = {
                default = "-";
                mpv = "🎵";
                spotify = "";
              };
              status-icons = {
                paused = "";
                playing = "⏸";
                stopped = "x";
              };
            };
          }
        ];
        style = ''
          /*
          @define-color base   #303446;
          @define-color mantle #292c3c;
          @define-color crust  #232634;

          @define-color text     #c6d0f5;
          @define-color subtext0 #a5adce;
          @define-color subtext1 #b5bfe2;

          @define-color surface0 #414559;
          @define-color surface1 #51576d;
          @define-color surface2 #626880;

          @define-color overlay0 #737994;
          @define-color overlay1 #838ba7;
          @define-color overlay2 #949cbb;

          @define-color blue      #8caaee;
          @define-color lavender  #babbf1;
          @define-color sapphire  #85c1dc;
          @define-color sky       #99d1db;
          @define-color teal      #81c8be;
          @define-color green     #a6d189;
          @define-color yellow    #e5c890;
          @define-color peach     #ef9f76;
          @define-color maroon    #ea999c;
          @define-color red       #e78284;
          @define-color mauve     #ca9ee6;
          @define-color pink      #f4b8e4;
          @define-color flamingo  #eebebe;
          @define-color rosewater #f2d5cf;
          */
          * {
              font-family: IosevkaTerm Nerd Font Mono, sans-serif;
              font-size: 10px;
          }

          window#waybar {
              background-color: @base;
              border-bottom: 3px solid @surface0;
              color: @text;
              transition-property: background-color;
              transition-duration: .5s;
          }

          window#waybar.hidden {
              opacity: 0.2;
          }

          /*
          window#waybar.empty {
              background-color: transparent;
          }
          window#waybar.solo {
              background-color: #FFFFFF;
          }
          */

          window#waybar.termite {
              background-color: #3F3F3F;
          }

          window#waybar.chromium {
              background-color: #000000;
              border: none;
          }

          button {
              /* Use box-shadow instead of border so the text isn't offset */
              box-shadow: inset 0 -3px transparent;
              /* Avoid rounded borders under each button name */
              border: 1px;
              border-radius: 2px;
              margin: 2px 0px
          }

          /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
          button:hover {
              background: inherit;
              box-shadow: inset 0 -3px #ffffff;
          }

          #workspaces button {
              padding: 0 5px;
              background-color: transparent;
              color: @text;
          }

          #workspaces button:hover {
              background: rgba(0, 0, 0, 0.2);
          }

          #workspaces button.focused {
              background-color: @sky;
              box-shadow: inset 0 -3px @teal;
              color: @crust;
          }

          #workspaces button.urgent {
              background-color: #eb4d4b;
          }

          #mode {
              background-color: #64727D;
              border-bottom: 0px solid #ffffff;
          }

          #battery,
          #cpu,
          #memory,
          #disk,
          #temperature,
          #backlight,
          #network,
          #pulseaudio,
          #custom-media,
          #custom-lock,
          #custom-sleep,
          #custom-darkman,
          #custom-screenshot,
          #custom-music,
          #custom-unread,
          #mpris,
          #tray,
          #mode,
          #idle_inhibitor,
          #scratchpad,
          #language,
          #mpd {
              padding: 0 6;
              color: @crust;
              border: 1;
              border-radius: 2;
              margin: 4 0;
          }

          #window,
          #workspaces {
              margin: 0 4px;
          }

          /* If workspaces is the leftmost module, omit left margin */
          .modules-left > widget:first-child > #workspaces {
              margin-left: 0;
          }

          /* If workspaces is the rightmost module, omit right margin */
          .modules-right > widget:last-child > #workspaces {
              margin-right: 0;
          }

          /*
          #clock {
              background-color: @rosewater;
          }
          */

          #battery {
              background-color: @flamingo;
          }

          #battery.charging, #battery.plugged {
              background-color: @green;
          }

          @keyframes blink {
              to {
                  background-color: #ffffff;
                  color: #000000;
              }
          }

          #battery.critical:not(.charging) {
              background-color: @red;
              color: @crust;
              animation-name: blink;
              animation-duration: 0.5s;
              animation-timing-function: linear;
              animation-iteration-count: infinite;
              animation-direction: alternate;
          }

          label:focus {
              background-color: @crust;
          }

          #cpu {
              background-color: #2ecc71;
              color: #000000;
          }

          #memory {
              background-color: @pink;
          }

          #disk {
              background-color: #964B00;
          }

          #backlight {
              background-color: #90b1b1;
          }

          #network {
              background-color: @mauve;
          }

          #network.disconnected {
              background-color: @red;
          }

          #pulseaudio {
              background-color: @yellow;
              color: #000000;
          }

          #pulseaudio.muted {
              background-color: @yellow;
              color: #2a5c45;
          }

          #custom-media {
              background-color: #66cc99;
              color: #2a5c45;
              min-width: 100px;
          }

          #custom-lock,
          #custom-music,
          #custom-unread,
          #custom-sleep,
          #mpris,
          #custom-darkman,
          #custom-screenshot {
              background-color: @blue;
              padding: 0 8px;
              color: @mantle;
          }

          #custom-media.custom-spotify {
              background-color: #66cc99;
          }

          #custom-media.custom-vlc {
              background-color: #ffa000;
          }

          #temperature {
              background-color: #f0932b;
          }

          #temperature.critical {
              background-color: #eb4d4b;
          }

          #tray {
              background-color: @base;
          }

          #tray > .passive {
              -gtk-icon-effect: dim;
          }

          #tray > .needs-attention {
              -gtk-icon-effect: highlight;
              background-color: #eb4d4b;
          }

          #idle_inhibitor {
              background-color: @overlay2;
              padding: 0 8px;
          }

          #idle_inhibitor.activated {
              background-color: @lavender;
          }

          #mpd {
              background-color: #66cc99;
              color: #2a5c45;
          }

          #mpd.disconnected {
              background-color: #f53c3c;
          }

          #mpd.stopped {
              background-color: #90b1b1;
          }

          #mpd.paused {
              background-color: #51a37a;
          }

          #language {
              background: @lavender;
              min-width: 16px;
          }

          #keyboard-state {
              background: #97e1ad;
              color: #000000;
              padding: 0 0px;
              margin: 0 5px;
              min-width: 16px;
          }

          #keyboard-state > label {
              padding: 0 5px;
          }

          #keyboard-state > label.locked {
              background: rgba(0, 0, 0, 0.2);
          }

          #scratchpad {
              background: rgba(0, 0, 0, 0.2);
          }

          #scratchpad.empty {
          	background-color: transparent;
          }
        '';
      };
    };
  }
