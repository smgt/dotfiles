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
    options.smgt.dev.vagrant = mkOption {
      default = false;
      type = types.bool;
      description = "Install vagrant";
    };
    config = mkIf cfg.enable {
      nixpkgs.config.allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "amp-cli"
        ];
      environment.systemPackages = with pkgs;
        [
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
          aider-chat
          amp-cli
        ]
        ++ optional cfg.vagrant pkgs.vagrant;

      virtualisation.virtualbox.host.enable = cfg.vagrant;
      users.extraGroups.vboxusers.members = ["simon"];
      boot.kernelParams = ["kvm.enable_virt_at_load=0"];

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
          "1penv/production" = {
            path = "${config.users.users.simon.home}/.config/1p-env/production";
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
