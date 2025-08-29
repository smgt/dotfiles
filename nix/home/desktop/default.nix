{
  lib,
  osConfig,
  pkgs,
  ...
}: let
  cfg = osConfig.smgt;
in
  with lib; {
    imports = [
      ./darkman.nix
      ./wezterm.nix
      ./waybar.nix
      ./kanshi.nix
      ./thunderbird.nix
      ./dunst.nix
      ./sway.nix
    ];
    config = mkIf cfg.desktop.enable {
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
      services = {
        clipman.enable = true;

        udiskie = {
          enable = true;
          tray = "always";
          automount = false;
        };

        blueman-applet.enable = true;

        network-manager-applet.enable = true;

        mpris-proxy.enable = true;
      };
    };
  }
