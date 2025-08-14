{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/microsocks.nix
    ../../modules/tailscale.nix
  ];

  boot.loader.grub.efiSupport = false;
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking = {
    hostName = "smgt-dev";
    networkmanager.enable = true;
    firewall = {
      enable = false;
      allowedTCPPorts = [ 2222 ];
    };
  };

  services = {
    syncthing = {
      enable = true;
      user = "simon";
    };
    openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        GatewayPorts = "yes";
      };
    };
    qemuGuest.enable = true;
  };

  virtualisation.docker.enable = true;

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
  # home-manager.users.simon.home.stateVersion = "23.11";
}
