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
  ];

  smgt = {
    desktop.enable = osConfig.smgt.desktop.enable;
    dev.enable = osConfig.smgt.dev.enable;
  };
}
