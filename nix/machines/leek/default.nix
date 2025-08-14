{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/tailscale.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment = {
    variables.HOSTNAME = "leek";
    systemPackages = with pkgs; [
      docker-compose
      nut
    ];
  };

  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        AllowUsers = [ "simon" ];
        PermitRootLogin = "no";
      };
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
    };
    resolved = {
      enable = true;
      domains = [
        "kaga.se"
        "zebu-yo.ts.net"
      ];
      extraConfig = ''
        # Required to make e.g. 'ping myStrom-Switch-A46FD0' work
        ResolveUnicastSingleLabel=yes

        DNSStubListener=yes
      '';
    };
  };

  networking = {
    hostName = "leek";
    firewall.enable = false;
    useNetworkd = true;

    nameservers = [
      "10.68.14.1"
      "100.100.100.100"
    ];

    vlans = {
      iot = {
        id = 10;
        interface = "eno1";
      };
    };
    interfaces.iot.ipv4.addresses = [
      {
        address = "10.68.16.2";
        prefixLength = 24;
      }
    ];
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
              runtimeInputs = [
                pkgs.rsync
                pkgs.openssh
              ];
              text = "rsync -avz --delete /srv/homeassistant/ simon@paprika.kaga.se:/homeassistant";
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
              runtimeInputs = [
                pkgs.rsync
                pkgs.openssh
              ];
              text = "rsync -avz --delete /srv/kuma/ simon@paprika.kaga.se:/kuma";
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
              runtimeInputs = [
                pkgs.rsync
                pkgs.openssh
              ];
              text = "rsync -avz --delete /srv/evcc/ simon@paprika.kaga.se:/evcc";
            }
          }/bin/evcc-backup";
        };
      };
    };
  };


  virtualisation.docker.enable = true;

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
      listen = [ { address = "0.0.0.0"; } ];
    };
    users = {
      admin = {
        actions = [
          "set"
          "fsd"
        ];
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
}
