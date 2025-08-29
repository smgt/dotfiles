{
  pkgs,
  lib,
  osConfig,
  ...
}:
let
  homeMonitor = "Dell Inc. DELL U3223QE F57H2P3";
  homeMonitor2 = "Dell Inc. DELL P2715Q V48W26BS986L";
  workMonitor = "Dell Inc. DELL U2723QE BBBMCP3";
  cfg = osConfig.smgt;
in
with lib;
{
  config = mkIf cfg.desktop.enable {
    services.kanshi = {
      enable = true;
      settings = [
        {
          profile = {
            name = "home";
            exec = [
              "${pkgs.sway}/bin/swaymsg workspace 9, move workspace to output '\"${homeMonitor2}\"'"
              "${pkgs.sway}/bin/swaymsg workspace 8, move workspace to output '\"${homeMonitor2}\"'"
              "${pkgs.sway}/bin/swaymsg workspace 2, move workspace to output '\"${homeMonitor}\"'"
              "${pkgs.sway}/bin/swaymsg workspace 1, move workspace to output '\"${homeMonitor}\"'"
              # "~/.config/sway/lid.sh"
            ];
            outputs = [
              {
                status = "enable";
                criteria = homeMonitor;
                scale = 2.0;
                # position = "1440,0";
                position = "1080,555";
                mode = "3840x2160";
              }
              {
                status = "enable";
                criteria = homeMonitor2;
                scale = 2.0;
                position = "0,0";
                mode = "3840x2160";
                transform = "90";
              }
              {
                status = "disable";
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
              "${pkgs.sway}/bin/swaymsg workspace 8, move workspace to output eDP-1"
              "${pkgs.sway}/bin/swaymsg workspace 9, move workspace to output eDP-1"
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
            outputs = [
              {
                status = "enable";
                criteria = "eDP-1";
                position = "1440,0";
                mode = "2880x1920";
              }
            ];
          };
        }
      ];
    };
  };
}
