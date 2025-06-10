{ nixpkgs, inputs, home-manager, }:
hostname:
{ stateVersion, system ? "x86_64-linux", user ? "simon" }:

let userHMConfig = ../users/${user};
in home-manager.lib.homeManagerConfiguration {
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  extraSpecialArgs = { inherit system hostname; };
  modules = [
    (import userHMConfig { inherit inputs; })
    {
      home = { inherit stateVersion; };
      programs.home-manager.enable = true;
      targets.genericLinux.enable = true;
    }
  ];
}
