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

  environment = { systemPackages = with pkgs; [ docker-compose nut ]; };

  power.ups = {
    enable = true;
    mode = "netserver";
    ups.datarummet = {
      driver = "usbhid-ups";
      port = "auto";
    };
    upsd = {
      enable = true;
      listen = [{ address = "10.68.14.3"; }];
    };
    users = {
      admin = {
        actions = [ "set" "fsd" ];
        instcmds = [ "all" ];
        passwordFile = "/etc/nut/admin";
      };
      observer = {
        upsmon = "secondary";
        passwordFile = "/etc/nut/observer";
      };
    };

    upsmon = {
      enable = true;
      monitor.datarummet = {
        type = "primary";
        user = "admin";
        passwordFile = "/etc/nut/admin";
        powerValue = 1;
        system = "datarummet@10.68.14.3";
      };
    };

  };

  # Select internationalisation properties.
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  system.stateVersion = "23.11";
  home-manager.users.simon.home.stateVersion = "23.11";
}
