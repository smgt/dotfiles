{config, pkgs, ...}:
{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.users.simon = (import ./simon);
}
