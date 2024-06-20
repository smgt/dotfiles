{ config, lib, pkgs, ... }:

{
  imports =
    [
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

  networking = {
    hostName = "leek"; # Define your hostname.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
    firewall.enable = false;
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  };

  # Select internationalisation properties.
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  system.stateVersion = "23.11";
}
