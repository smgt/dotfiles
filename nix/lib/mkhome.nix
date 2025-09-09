{
  nixpkgs,
  inputs,
  home-manager,
}: hostname: {
  stateVersion,
  system ? "x86_64-linux",
  user ? "simon",
}: let
  userHMConfig = ../home/standalone.nix;
in
  home-manager.lib.homeManagerConfiguration {
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    extraSpecialArgs = {inherit system hostname;};
    modules = [
      inputs.sops-nix.homeManagerModules.sops
      (import userHMConfig {inherit inputs;})
      inputs.catppuccin.homeModules.catppuccin
      {
        home = {inherit stateVersion;};
        programs.home-manager.enable = true;
        targets.genericLinux.enable = true;
      }
    ];
  }
