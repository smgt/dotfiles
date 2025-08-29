{inputs, ...}: {lib, ...}: {
  imports = [
    ./base.nix
    ./tmux.nix
    ./zsh.nix
    ./dev.nix
  ];
  smgt.dev.enable = true;
}
