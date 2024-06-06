{config, pkgs, ...}:

{
  imports = [ <home-manager/nixos> ];

  home-manager.users.simon = (import ./simon);
}
