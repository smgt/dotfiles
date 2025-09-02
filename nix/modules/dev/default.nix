{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.smgt.dev;
  secretspath = builtins.toString inputs.secrets;
in
  with lib; {
    options.smgt.dev.enable = mkOption {
      default = false;
      type = types.bool;
      description = "Enable development tools";
    };
    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        dive
        gcc
        gdb
        go
        gotools
        gnumake
        gitFull
        git-lfs
        gotraceui
        # libgcc
        #nodejs_22
        perl
        python3
        rustc
        cargo
        siege
      ];
      sops = {
        age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
        defaultSopsFile = "${secretspath}/dev.yml";
        secrets = {
          "dev" = {};
          "1penv/config" = {
            path = "${config.users.users.simon.home}/.config/1p-env/config";
            owner = config.users.users.simon.name;
          };
          "1penv/integration" = {
            path = "${config.users.users.simon.home}/.config/1p-env/integration";
            owner = config.users.users.simon.name;
          };
        };
        templates."dev.env" = {
          content = config.sops.placeholder.dev;
          owner = config.users.users.simon.name;
        };
      };
    };
  }
