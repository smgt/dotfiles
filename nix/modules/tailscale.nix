{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.smgt.tailscale;
in {
  options.smgt.tailscale.enable = lib.mkOption {
    default = true;
    type = lib.types.bool;
    description = "Setup tailscale";
  };
  options.smgt.tailscale.nodeType = lib.mkOption {
    default = "client";
    type = lib.types.enum [
      "client"
      "server"
      "both"
    ];
    description = ''
      Enables settings required for Tailscale's routing features like subnet routers and exit nodes.

      When set to `client` or `both`, reverse path filtering will be set to loose instead of strict.
      When set to `server` or `both`, IP forwarding will be enabled.
    '';
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.tailscale
    ];

    services.tailscale = {
      enable = true;
      openFirewall = true;
      useRoutingFeatures = cfg.nodeType;
    };
  };
}
