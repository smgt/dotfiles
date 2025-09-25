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
    ./ssh-agent.nix
  ];

  sops = {
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    defaultSopsFile = "${secretspath}/secrets.yml";
    secrets = {
    };
  };

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
