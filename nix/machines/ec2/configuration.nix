{ config, lib, pkgs, ... }:

{
  imports =
    [
      ../../common
      ../../common/users/home-manager.nix
      /etc/nixos/hardware-configuration.nix
    ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  environment.variables.HOSTNAME = "simong-nixos";

  services.openssh.enable = true;

  services.logind.extraConfig = ''
    RuntimeDirectorySize=12G
    HandleLidSwitchDocked=ignore
  '';

  networking = {
    hostName = "simong-nixos"; # Define your hostname.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
    firewall.enable = false;
  };


  system.stateVersion = "24.05";
}
