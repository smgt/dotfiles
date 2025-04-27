{ config, lib, pkgs, ... }:

{
  imports = [
    ../../common
    ../../common/users/home-manager.nix
    /etc/nixos/hardware-configuration.nix
    ../../modules/tailscale.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.variables.HOSTNAME = "leek";

  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        AllowUsers = [ "simon" ];
        PermitRootLogin = "no";
      };
    };
    resolved = {
      enable = true;
      extraConfig = ''
        DNS=10.68.14.1
        DNSStubListener=yes
      '';
    };
  };

  systemd = {
    network.enable = true;
    timers = {
      "homeassistant-backup" = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
          Unit = "homeassistant-backup";
        };
      };
      "kuma-backup" = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
          Unit = "kuma-backup";
        };
      };
      "evcc-backup" = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
          Unit = "evcc-backup";
        };
      };
    };
    services = {
      "homeassistant-backup" = {
        serviceConfig = {
          Type = "oneshot";
          User = "simon";
          ExecStart = "${
              pkgs.writeShellApplication {
                name = "homeassistant-backup";
                runtimeInputs = [ pkgs.rsync pkgs.openssh ];
                text =
                  "rsync -avz --delete /srv/homeassistant/ simon@paprika.kaga.se:/homeassistant";
              }
            }/bin/homeassistant-backup";
        };
      };
      "kuma-backup" = {
        serviceConfig = {
          Type = "oneshot";
          User = "simon";
          ExecStart = "${
              pkgs.writeShellApplication {
                name = "kuma-backup";
                runtimeInputs = [ pkgs.rsync pkgs.openssh ];
                text =
                  "rsync -avz --delete /srv/kuma/ simon@paprika.kaga.se:/kuma";
              }
            }/bin/kuma-backup";
        };
      };
      "evcc-backup" = {
        serviceConfig = {
          Type = "oneshot";
          User = "simon";
          ExecStart = "${
              pkgs.writeShellApplication {
                name = "evcc-backup";
                runtimeInputs = [ pkgs.rsync pkgs.openssh ];
                text =
                  "rsync -avz --delete /srv/evcc/ simon@paprika.kaga.se:/evcc";
              }
            }/bin/evcc-backup";
        };
      };
    };
  };

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
      description = "Back-UPS BX750MI";
    };
    upsd = {
      enable = true;
      listen = [{ address = "0.0.0.0"; }];
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
