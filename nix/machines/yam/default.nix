{
  modulesPath,
  config,
  ...
}: let
  cfg = config.smgt;
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./hardware-configuration.nix
    ./disk-config.nix
  ];

  smgt = {
    dev = {
      enable = true;
    };
    desktop = {
      enable = true;
      steam = true;
    };
    yubikey.enable = true;
  };

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      systemd.enable = true;
    };
  };

  networking = {
    hostName = "yam";
    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };
    firewall = {
      enable = false;
      allowedTCPPorts = [22];
    };
  };

  powerManagement.enable = true;

  systemd = {
    network.enable = true;
    network.wait-online.enable = false;
    #services.NetworkManager-wait-online.enable = false;
    #services.tailscaled.after = ["systemd-networkd-wait-online.service"];
  };

  services = {
    resolved = {
      enable = true;
    };
    fwupd.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
    };
    blueman.enable = true;
    # syncthing = {
    #   enable = true;
    #   user = "simon";
    #   extraFlags = [ "--no-default-folder" ];
    # };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true; # Show battery charge of Bluetooth devices
      };
    };
  };

  virtualisation.docker.enable = true;

  # Include gui setup, wayland, sway, etc
  # home-manager = {
  #   users.simon = ../../home/gui.nix;
  #   useGlobalPkgs = true;
  #   useUserPackages = true;
  # };

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11";
}
