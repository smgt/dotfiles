{ config, lib, pkgs, ... }:

{
  imports =
    [
      ../../common	
      ../../common/users/home-manager.nix
      /etc/nixos/hardware-configuration.nix
    ];

  boot.loader.grub.efiSupport = false;
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  # Enable ip forwarding to allow tailscale routes
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  boot.kernel.sysctl."net.ipv6.conf.all.forwarding" = 1;

  networking.hostName = "smgt-dev";
  networking.networkmanager.enable = true;
  #systemd.network.wait-online.enable = false;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  services.tailscale.enable = true;

  virtualisation.docker.enable = true;

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}

