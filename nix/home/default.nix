{inputs, ...}: {
  config,
  osConfig,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./base.nix
    ./tmux.nix
    ./zsh.nix
    ./dev.nix
    ./syncthing.nix
    ./desktop
    ./ssh-agent.nix
  ];

  smgt = {
    desktop.enable = osConfig.smgt.desktop.enable;
    dev.enable = osConfig.smgt.dev.enable;
    syncthing.enable = osConfig.smgt.syncthing.enable;
    ssh-agent = {
      enable = true;
      defaultTimeout = 3600;
    };
  };
}
