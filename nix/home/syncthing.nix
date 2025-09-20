{
  config,
  lib,
  ...
}: let
  cfg = config.smgt.syncthing;
in
  with lib; {
    options.smgt.syncthing.enable = mkOption {
      default = false;
      type = lib.types.bool;
      description = "Install syncthing";
    };
    config = mkIf cfg.enable {
      services.syncthing = {
        inherit (cfg) enable;
        overrideDevices = false;
        overrideFolders = false;
      };
    };
  }
