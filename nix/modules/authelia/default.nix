{
  inputs,
  config,
  pkgs,
  vars,
  ...
}: let
  secretspath = builtins.toString inputs.secrets;
in {
  sops = {
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    defaultSopsFile = "${secretspath}/authelia.yml";
    secrets = {
      "storageEncryptionKey" = {
        owner = "authelia-main";
        group = "authelia-main";
      };
      "jwtSecret" = {
        owner = "authelia-main";
        group = "authelia-main";
      };
      "sessionSecret" = {
        owner = "authelia-main";
        group = "authelia-main";
      };
      "users" = {
        owner = "authelia-main";
        group = "authelia-main";
      };
      "access_control" = {
        owner = "authelia-main";
        group = "authelia-main";
      };
      "identity_providers" = {
        owner = "authelia-main";
        group = "authelia-main";
      };
      "smtp" = {
        owner = "authelia-main";
        group = "authelia-main";
      };
    };
  };
  environment = {
    systemPackages = with pkgs; [
      authelia
    ];
  };
  services.authelia.instances = {
    main = {
      enable = true;
      secrets = {
        storageEncryptionKeyFile = config.sops.secrets.storageEncryptionKey.path;
        jwtSecretFile = config.sops.secrets.jwtSecret.path;
        sessionSecretFile = config.sops.secrets.sessionSecret.path;
      };
      settingsFiles = [
        config.sops.secrets.access_control.path
        config.sops.secrets.identity_providers.path
        config.sops.secrets.smtp.path
      ];
      settings = {
        theme = "light";
        default_2fa_method = "totp";
        log = {
          level = "info";
        };
        server = {
          disable_healthcheck = true;
          address = "tcp://0.0.0.0:9091";
          # Caddy uses ForwardAuth Authz implementatation
          endpoints.authz.forward-auth.implementation = "ForwardAuth";
        };
        totp = {
          issuer = vars.authelia.domain1;
        };
        storage.local = {
          path = "/var/lib/authelia-main/db.sqlite3";
        };
        # notifier.filesystem.filename = "/var/lib/authelia-main/notification.txt";
        authentication_backend = {
          password_reset.disable = true;
          password_change.disable = true;
          file = {
            path = config.sops.secrets.users.path;
            password = {
              algorithm = "argon2";
            };
          };
        };
        session = {
          cookies = [
            {
              domain = vars.authelia.domain1;
              authelia_url = vars.authelia.base_url1;
              default_redirection_url = "https://${vars.authelia.domain1}";
            }
            {
              domain = vars.authelia.domain2;
              authelia_url = vars.authelia.base_url2;
              default_redirection_url = "https://${vars.authelia.domain2}";
            }
          ];
        };
        ntp = {
          address = "udp://time.cloudflare.com:123";
        };
        webauthn = {
          enable_passkey_login = false;
          display_name = vars.authelia.display_name;
          attestation_conveyance_preference = "indirect";
          timeout = "60 seconds";
        };
      };
    };
  };
}
