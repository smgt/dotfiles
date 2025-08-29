{
  description = "dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    smgtvim.url = "git+https://0xee.cc/smgt/nix-nvim";
    secrets = {
      url = "git+ssh://git@0xee.cc/smgt/nix-secrets.git";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    utils,
    home-manager,
    disko,
    nixos-hardware,
    nix-flatpak,
    smgtvim,
    sops-nix,
    ...
  } @ inputs: let
    overlays = [];
    mkHome = import ./nix/lib/mkhome.nix {
      inherit
        nixpkgs
        home-manager
        inputs
        ;
    };
    mkSystem = import ./nix/lib/mksystem.nix {
      inherit
        overlays
        nixpkgs
        inputs
        ;
    };
  in
    {
      # Home manager configurations
      homeConfigurations.kale = mkHome "kale" {stateVersion = "25.05";};
      homeConfigurations.sugarsnap = mkHome "sugarsnap" {stateVersion = "25.05";};

      # NixOS configurations
      nixosConfigurations = {
        leek = mkSystem "leek" {};
        fennel = mkSystem "fennel" {};
        smgt-dev = mkSystem "smgt-dev" {};
        fly = mkSystem "fly" {};
        yam = mkSystem "yam" {
          extraModules = [
            # Fixes to suspend...
            nixos-hardware.nixosModules.framework-amd-ai-300-series
            nix-flatpak.nixosModules.nix-flatpak
          ];
        };
      };
    }
    //
    # Per-system outputs (for development shells, etc.)
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in {
        devShells = {
          default = pkgs.mkShell {
            nativeBuildInputs = [smgtvim.packages.${system}.default];
            packages = with pkgs; [
              stylua
              lua-language-server
            ];
          };
        };
      }
    );
}
