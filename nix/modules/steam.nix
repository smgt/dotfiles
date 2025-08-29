{
  config,
  lib,
  ...
}: let
  cfg = config.smgt;
in
  with lib; {
    options.smgt.desktop.steam = lib.mkOption {
      default = false;
      type = lib.types.bool;
      description = "Install steam";
    };
    config = mkIf cfg.desktop.steam {
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
        localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      };
    };
  }
