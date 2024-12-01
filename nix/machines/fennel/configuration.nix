{ config, lib, pkgs, ... }:
let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in with lib; {
  imports =
    [
      ../../common
      ../../common/users/home-manager.nix
      /etc/nixos/hardware-configuration.nix
      /etc/nixos/networking.nix
      ../../modules/tailscale.nix
    ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  environment.variables.HOSTNAME = "fennel";

  services.logind.extraConfig = ''
    RuntimeDirectorySize=12G
    HandleLidSwitchDocked=ignore
  '';

  networking = {
    hostName = "fennel";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443];
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

  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
      };
      extraConfig = ''
        Match User simon
          PasswordAuthentication yes
      '';
    };

    caddy = {
      enable = true;
      email = "simon@kampgate.se";
      virtualHosts."git.0xee.cc".extraConfig = ''
        reverse_proxy unix//run/forgejo/forgejo.sock
      '';
      virtualHosts."0xee.cc".extraConfig = ''
        reverse_proxy unix//run/forgejo/forgejo.sock
      '';
    };


    forgejo = {
      enable = true;
      package = unstable.forgejo;
      user = "git";
      lfs.enable = true;
      database = {
        createDatabase = false;
        type = "postgres";
        socket = "/run/postgresql";
        user = "forgejo";
        name = "forgejo";
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
        webhook = {
          ALLOWED_HOST_LIST = "ci.0xee.cc";
        };
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
