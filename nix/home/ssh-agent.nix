{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.smgt.ssh-agent;
in {
  options.smgt.ssh-agent = {
    enable = lib.mkEnableOption "OpenSSH private key agent";

    package = lib.mkPackageOption pkgs "openssh" {};

    socket = lib.mkOption {
      type = lib.types.str;
      default = "ssh-agent";
      example = "ssh-agent/socket";
      description = ''
        The agent's socket; interpreted as a suffix to {env}`$XDG_RUNTIME_DIR`.
      '';
    };
    defaultTimeout = lib.mkOption {
      type = lib.types.nullOr lib.types.ints.positive;
      default = 60 * 60 * 8;
      example = 60 * 60 * 8; # 8h
      description = ''
        Set a default value for the maximum lifetime in seconds of identities added to the agent.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      (lib.hm.assertions.assertPlatform "services.ssh-agent" pkgs lib.platforms.linux)
    ];

    home.sessionVariablesExtra = ''
      if [ -z "$SSH_AUTH_SOCK" ]; then
        export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/${cfg.socket}
      fi
    '';

    systemd.user.services.ssh-agent = {
      Install.WantedBy = ["default.target"];
      Unit = {
        Description = "SSH authentication agent";
        Documentation = "man:ssh-agent(1)";
      };
      Service.ExecStart = "${lib.getExe' cfg.package "ssh-agent"} -D -a %t/${cfg.socket}${
        lib.optionalString (cfg.defaultTimeout != null) " -t ${toString cfg.defaultTimeout}"
      }";
    };
  };
}
