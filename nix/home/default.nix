{inputs, ...}: {
  config,
  osConfig,
  pkgs,
  lib,
  ...
}: let
  secretspath = builtins.toString inputs.secrets;
in {
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

  # sops = {
  #   age.sshKeyPaths = ["${home.homeDirectory}/.ssh/id_ed25519"];
  #   defaultSopsFile = "${secretspath}/secrets.yml";
  # };
  # [[ -a ${config.sops.templates."default.env".path} ]] && source ${ config.sops.templates."default.env".path }
}
