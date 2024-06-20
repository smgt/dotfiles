{ config, lib, pkgs, ... }:

{
  imports =
    [
      ../../common	
      ../../common/users/home-manager.nix
      /etc/nixos/hardware-configuration.nix
      ../../modules/microsocks.nix
      ../../modules/tailscale.nix
    ];

  boot.loader.grub.efiSupport = false;
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only


  networking.hostName = "smgt-dev";
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
  };

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  services.qemuGuest.enable = true;

  virtualisation.docker.enable = true;

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}

