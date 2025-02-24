{ config, lib, pkgs, ... }:

{
  imports = [
    ../../common
    ../../common/users/home-manager.nix
    /etc/nixos/hardware-configuration.nix
    ../../modules/tailscale.nix
    ../../modules/coredns.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.variables.HOSTNAME = "leek";

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "simon" ];
      PermitRootLogin = "no";
    };
  };

  systemd.network.enable = true;

  networking = {
    hostName = "leek";
    firewall.enable = false;
    useNetworkd = true;
    vlans = {
      iot = {
        id = 10;
        interface = "eno1";
      };
    };
    interfaces.iot.ipv4.addresses = [{
      address = "10.68.16.2";
      prefixLength = 24;
    }];
  };

  virtualisation.docker.enable = true;

  environment = { systemPackages = with pkgs; [ docker-compose ]; };

  # Select internationalisation properties.
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  system.stateVersion = "23.11";
  home-manager.users.simon.home.stateVersion = "23.11";
}
