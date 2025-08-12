{ nixpkgs, overlays, disko, inputs, nixos-hardware, }:

name:
{ system ? "x86_64-linux", user ? "simon", gui ? false, extraModules ? [ ], }:

let
  # The config files for this system.
  machineConfig = ../machines/${name};
  userOSConfig = ../machines;
  userHMConfig = ../home;
  home-manager = inputs.home-manager.nixosModules;
  extraModule = extraModules;
in nixpkgs.lib.nixosSystem rec {
  inherit system;

  modules = [
    # Apply our overlays. Overlays are keyed by system type so we have
    # to go through and apply our system type. We do this first so
    # the overlays are available globally.
    {
      nixpkgs.overlays = overlays;
    }

    # Allow unfree packages.
    { nixpkgs.config.allowUnfree = true; }

    machineConfig
    userOSConfig
    disko.nixosModules.disko
    home-manager.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.${user} = import userHMConfig { inherit inputs; };
      };
    }

    # We expose some extra arguments so that our modules can parameterize
    # better based on these values.
    {
      config._module.args = {
        inherit inputs;
        currentSystem = system;
        currentSystemName = name;
        currentSystemUser = user;
      };
    }
  ] ++ extraModule;
}
