{config, pkgs, ...}:
{
  imports = [
    <home-manager/nixos>
  ];

  home-manager = {
    useGlobalPkgs = true;
    users.simon = import ./simon;
  };
}
