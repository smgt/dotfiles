{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ../../modules/tailscale.nix
  ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  environment = {
    variables.HOSTNAME = "fennel";
    systemPackages = with pkgs; [ forgejo-cli ];
  };

  networking = {
    hostName = "fennel";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
      ];
    };
  };

  users.users = {
    git = {
      home = "/var/lib/forgejo";
      useDefaultShell = true;
      group = "forgejo";
      isSystemUser = true;
    };
  };

  virtualisation.docker.enable = true;
  systemd = {
    timers = {
      "forgejo-backup" = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
          Unit = "forgejo-backup";
        };
      };
    };
    services = {
      "forgejo-backup" = {
        serviceConfig = {
          Type = "oneshot";
          User = "git";
          ExecStart = "${
            pkgs.writeShellApplication {
              name = "forgejo-backup";
              runtimeInputs = [
                pkgs.findutils
                pkgs.rsync
                pkgs.openssh
              ];
              text = ''
              find /var/lib/forgejo/dump/ -type f -mtime +15 -exec rm -f {} +
              rsync -avz --delete /var/lib/forgejo/dump/ simon@paprika.kaga.se:/forgejo
              '';
            }
          }/bin/forgejo-backup";
        };
      };
    };
  };

  services = {

    logind = {
      extraConfig = ''
        RuntimeDirectorySize=12G
        HandleLidSwitchDocked=ignore
      '';
    };

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
      };
    };

    caddy = {
      enable = true;
      email = "simon@kampgate.se";
      virtualHosts = {
        "0xee.cc" = {
          serverAliases = [ "git.0xee.cc" ];
          logFormat = ''
            output file ${config.services.caddy.logDir}/0xeecc-access.log {
              roll_size 100mb
              roll_keep 5
              roll_keep_for 720h
            }
          '';
          extraConfig = ''
            reverse_proxy unix//run/forgejo/forgejo.sock
          '';
        };
        "smgt.me" = {
          serverAliases = [
            "www.smgt.me"
            "simongate.com"
            "www.simongate.com"
          ];
          logFormat = ''
            output file ${config.services.caddy.logDir}/smgt-access.log {
              roll_size 100mb
              roll_keep 5
              roll_keep_for 720h
            }
          '';
          extraConfig = ''
            header /.well-known/webfinger Content-Type application/json
            root * /www/smgt
            file_server
          '';
        };
      };

    };

    forgejo = {
      enable = true;
      user = "git";
      lfs.enable = true;
      database = {
        createDatabase = false;
        type = "postgres";
        socket = "/run/postgresql";
        user = "forgejo";
        name = "forgejo";
      };
      dump = {
        enable = true;
        type = "tar.bz2";
      };
      settings = {
        default = {
          RUN_MODE = "prod";
        };
        server = {
          ROOT_URL = "https://0xee.cc";
          SSH_DOMAIN = "0xee.cc";
          PROTOCOL = "http+unix";
          DOMAIN = "0xee.cc";
        };
        service = {
          REGISTER_EMAIL_CONFIRM = false;
          ENABLE_NOTIFY_MAIL = false;
          DISABLE_REGISTRATION = true;
          ALLOW_ONLY_EXTERNAL_REGISTRATION = false;
          ENABLE_CAPTCHA = false;
          REQUIRE_SIGNIN_VIEW = false;
          DISABLE_USERS_PAGE = false;
          DEFAULT_KEEP_EMAIL_PRIVATE = true;
          DEFAULT_ALLOW_CREATE_ORGANIZATION = true;
          DEFAULT_ENABLE_TIMETRACKING = true;
          NO_REPLY_ADDRESS = "no-reply@0xee.cc";
        };
        picture = {
          DISABLE_GRAVATAR = true;
          ENABLE_FEDERATED_AVATAR = true;
        };
        openid = {
          ENABLE_OPENID_SIGNIN = true;
          ENABLE_OPENID_SIGNUP = false;
        };
        session = {
          PROVIDER = "file";
        };
        # webhook = { ALLOWED_HOST_LIST = "ci.0xee.cc"; };
      };
    };

    postgresql = {
      enable = true;
      package = pkgs.postgresql_16;
      ensureDatabases = [ "forgejo" ];
      ensureUsers = [
        {
          name = "forgejo";
          ensureDBOwnership = true;
        }
      ];
      authentication = pkgs.lib.mkOverride 10 ''
        #type database  DBuser  auth-method
        local sameuser  all     peer       map=superuser_map
      '';
      identMap = ''
        # ArbitraryMapName systemUser DBUser
        superuser_map      root      postgres
        superuser_map      postgres  postgres
        superuser_map      git       forgejo
        # Let other names login as themselves
        superuser_map      /^(.*)$   \1
      '';
    };
  };

  system.stateVersion = "24.05";
  home-manager.users.simon.home.stateVersion = "24.05";
}
