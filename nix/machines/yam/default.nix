{ modulesPath, config, lib, pkgs, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./hardware-configuration.nix
    ./disk-config.nix
    ../../modules/tailscale.nix
    ./../wayland.nix
  ];

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "yam";
    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };
    firewall = {
      enable = false;
      allowedTCPPorts = [ 22 ];
    };
  };

  powerManagement.enable = true;

  systemd = {
    network.enable = true;
    services.NetworkManager-wait-online.enable = false;
    services.tailscaled.after = [ "systemd-networkd-wait-online.service" ];
  };

  services = {
    resolved = { enable = true; };
    fwupd.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
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
  };

  virtualisation.docker.enable = true;

  # Include gui setup, wayland, sway, etc
  home-manager = {
    users.simon = ../../home/gui.nix;
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11";
}
