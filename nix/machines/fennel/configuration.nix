{ config, lib, pkgs, ... }:
let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in with lib; {
  imports =
    [
      ../../common
      ../../common/users/home-manager.nix
      /etc/nixos/hardware-configuration.nix
      /etc/nixos/networking.nix
      ../../modules/tailscale.nix
    ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  environment.variables.HOSTNAME = "fennel";

  services.logind.extraConfig = ''
    RuntimeDirectorySize=12G
    HandleLidSwitchDocked=ignore
  '';

  networking = {
    hostName = "fennel";
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443];
    };
  };

  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
      };
      extraConfig = ''
        Match User simon
          PasswordAuthentication yes
      '';
    };
  };

  system.stateVersion = "24.05";
  home-manager.users.simon.home.stateVersion = "24.05";
}
