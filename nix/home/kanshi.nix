{ pkgs, ... }:
let
  homeMonitor = "Dell Inc. DELL U3223QE F57H2P3";
  # homeMonitor = "Unknown Unknown Unknown";
  workMonitor = "Dell Inc. DELL U2723QE BBBMCP3";
in {
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile = {
          name = "home";
          exec = [
            "${pkgs.sway}/bin/swaymsg workspace 1, move workspace to output '\"${homeMonitor}\"'"
            "${pkgs.sway}/bin/swaymsg workspace 2, move workspace to output '\"${homeMonitor}\"'"
            # "~/.config/sway/lid.sh"
          ];
          outputs = [
            {
              status = "enable";
              criteria = homeMonitor;
              scale = 2.0;
              position = "1440,0";
              mode = "3840x2160";
            }
            {
              status = "enable";
              criteria = "eDP-1";
              position = "0,120";
              mode = "2880x1920";
            }
          ];
        };
      }
      {
        profile = {
          name = "work";
          exec = [
            "${pkgs.sway}/bin/swaymsg workspace 1, move workspace to output '\"${workMonitor}\"'"
            "${pkgs.sway}/bin/swaymsg workspace 2, move workspace to output '\"${workMonitor}\"'"
            # "~/.config/sway/lid.sh"
          ];
          outputs = [
            {
              status = "enable";
              criteria = workMonitor;
              scale = 2.0;
              position = "1440,0";
              mode = "3840x2160";
            }
            {
              status = "enable";
              criteria = "eDP-1";
              position = "0,0";
              mode = "2880x1920";
            }
          ];
        };
      }
      {
        profile = {
          name = "nomad";
          outputs = [{
            status = "enable";
            criteria = "eDP-1";
            position = "1440,0";
            mode = "2880x1920";
          }];
        };
      }
    ];

    # kale
    # profile home {
    #   output "Dell Inc. DELL U3223QE F57H2P3" enable scale 2 position 0,0 mode 3840x2160
    #   output eDP-1 enable position 240,1080 mode 2880x1800
    #   exec swaymsg workspace 1, move workspace to output '"Dell Inc. DELL U3223QE F57H2P3"'
    #   exec swaymsg workspace 2, move workspace to output '"Dell Inc. DELL U3223QE F57H2P3"'
    #   exec ~/.config/sway/lid.sh
    # }
    #
    # profile hometmp {
    #   output "Dell Inc. DELL P2715Q V48W26BS986L" enable scale 2 position 0,0 mode 3840x2160
    #   output eDP-1 enable position 240,1080 mode 2880x1800
    #   exec swaymsg workspace 1, move workspace to output '"Dell Inc. DELL P2715Q V48W26BS986L"'
    #   exec swaymsg workspace 2, move workspace to output '"Dell Inc. DELL P2715Q V48W26BS986L"'
    #   exec ~/.config/sway/lid.sh
    # }
    #
    # profile readly {
    #   output eDP-1 enable position 0,180 mode 2880x1800
    #   output "Dell Inc. DELL U2723QE BBBMCP3" enable scale 2 position 1440,0 mode 3840x2160
    #   exec swaymsg workspace 1, move workspace to output '"Dell Inc. DELL U2723QE BBBMCP3"'
    #   exec swaymsg workspace 2, move workspace to output '"Dell Inc. DELL U2723QE BBBMCP3"'
    # }
    #
    # profile nomad {
    #   output eDP-1 enable position 0,0 mode 2880x1800
    # }

    #sugarsnap
    # profile {
    #   output "Dell Inc. DELL P2715Q V48W26BS986L" disable
    #   output "Dell Inc. DELL U3223QE F57H2P3" enable position 0,0 mode 3840x2160@60Hz scale 2
    # }
    #
    # profile mono {
    #   output "Dell Inc. DELL P2715Q V48W26BS986L" disable
    #   output "Dell Inc. DELL U3223QE F57H2P3" enable position 0,0 mode 3840x2160@60Hz scale 2
    # }
    #
    # profile landscape {
    #   output "Dell Inc. DELL P2715Q V48W26BS986L" enable position 0,0 mode 3840x2160@60Hz scale 2
    #   output "Dell Inc. DELL U3223QE F57H2P3" enable position 1920,0 mode 3840x2160@60Hz scale 2
    # }
  };
}
