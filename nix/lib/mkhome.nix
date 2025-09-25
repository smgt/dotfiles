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
  vars = import "${inputs.secrets}/default.nix";
in
  home-manager.lib.homeManagerConfiguration {
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [inputs.murp.overlays.murp];
    };
    extraSpecialArgs = {inherit system hostname vars;};
    modules = [
      inputs.murp.homeModules.murp
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
