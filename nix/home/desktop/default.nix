{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.smgt.desktop;
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
      ./wofi.nix
    ];
    options.smgt.desktop.enable = mkOption {
      default = false;
      type = lib.types.bool;
      description = "enable or disable";
    };
    config = mkIf cfg.enable {
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
