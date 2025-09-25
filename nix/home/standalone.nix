{inputs, ...}: {lib, ...}: {
  imports = [
    ./base.nix
    ./tmux.nix
    ./zsh.nix
    ./dev.nix
    ./syncthing.nix
    ./ssh-agent.nix
  ];
  smgt = {
    dev.enable = true;
    ssh-agent.enable = true;
  };
}
