{ config, lib, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/secret.nix
      ../../common
      ../../common/users/home-manager.nix
      /etc/nixos/hardware-configuration.nix
      ../../modules/tailscale.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.variables.HOSTNAME = "leek";

  services.openssh.enable = true;

  systemd.network.enable = true;

  networking = {
    hostName = "leek";
    firewall.enable = false;
    useNetworkd = true;
  };


  virtualisation.docker.enable = true;

  environment = {
    systemPackages = with pkgs; [
      docker-compose
    ];
  };

  # Select internationalisation properties.
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  system.stateVersion = "23.11";
}
