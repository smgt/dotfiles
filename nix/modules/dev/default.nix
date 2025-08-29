{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.smgt.dev;
in
  with lib; {
    options.smgt = {
      dev.enable = mkOption {
        default = false;
        type = types.bool;
        description = "Enable development tools";
      };
    };
    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        dive
        gcc
        gdb
        go
        gotools
        gnumake
        gitFull
        git-lfs
        # libgcc
        #nodejs_22
        perl
        python3
        rustc
        cargo
        siege
      ];
    };
  }
