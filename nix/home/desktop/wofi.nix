{
  config,
  lib,
  ...
}: let
  cfg = config.smgt.desktop;
in
  with lib; {
    config = mkIf cfg.enable {
      programs.wofi = {
        enable = true;
        settings = {
          insensitive = true;
          allow_images = true;
          image_size = 40;
          width = 800;
          height = 400;
        };
        style = builtins.readFile ./wofi.style;
      };
    };
  }
