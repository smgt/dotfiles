{
  nixpkgs,
  overlays,
  inputs,
}: name: {
  system ? "x86_64-linux",
  user ? "simon",
  dev ? false,
  desktop ? false,
  extraModules ? [],
}: let
  # The config files for this system.
  userOSConfig = ../machines;
  machineConfig = ../machines/${name};
  userHMConfig = ../home;
  extraModule = extraModules;
in
  nixpkgs.lib.nixosSystem rec {
    inherit system;

    # Pass extra args
    specialArgs = {
      inherit desktop dev;
    };

    modules =
      [
        # Apply our overlays. Overlays are keyed by system type so we have
        # to go through and apply our system type. We do this first so
        # the overlays are available globally.
        {
          nixpkgs.overlays = overlays;
        }

        # Allow unfree packages.
        {nixpkgs.config.allowUnfree = true;}

        inputs.sops-nix.nixosModules.sops
        inputs.disko.nixosModules.disko
        inputs.home-manager.nixosModules.home-manager
        inputs.nix-flatpak.nixosModules.nix-flatpak

        machineConfig
        userOSConfig

        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${user} = import userHMConfig {inherit inputs;};
            sharedModules = [
              inputs.sops-nix.homeManagerModules.sops
            ];
            extraSpecialArgs = specialArgs;
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
      ]
      ++ extraModule;
  }
