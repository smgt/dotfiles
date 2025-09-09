{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.smgt.yubikey;
in
  with lib; {
    options.smgt.yubikey.enable = mkOption {
      default = false;
      type = lib.types.bool;
      description = "Install yubikey tools";
    };
    config = mkIf cfg.enable {
      services = {
        pcscd.enable = true;
      };
      environment.systemPackages = with pkgs; [
        yubioath-flutter
        yubikey-manager
        # We need it for ssh-agent to ask for Yubikey PIN
        x11_ssh_askpass
      ];
    };
  }
