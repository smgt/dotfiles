{
  config,
  lib,
  ...
}: let
  cfg = config.smgt;
in
  with lib; {
    config = mkIf cfg.desktop.enable {
      home.file = {
        "${config.xdg.configHome}/waybar/config".source = ./waybar.config;
      };
      programs.waybar = {
        enable = true;
        style = builtins.readFile ./waybar.style;
      };
    };
  }
