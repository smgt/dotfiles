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
  };

  outputs = { self, nixpkgs, utils, home-manager, disko, ... }@inputs:
    let
      overlays = [ ];
      mkHome =
        import ./nix/lib/mkhome.nix { inherit nixpkgs home-manager inputs; };
      mkSystem =
        import ./nix/lib/mksystem.nix { inherit overlays nixpkgs inputs disko; };
    in
    {
      # Home manager configurations
      homeConfigurations.kale = mkHome "kale" { stateVersion = "25.05"; };
      homeConfigurations.sugarsnap =
        mkHome "sugarsnap" { stateVersion = "25.05"; };

      # NixOS configurations
      nixosConfigurations = {
        testvm = mkSystem "testvm";
        leek = mkSystem "leek";
      };
    } //
    # Per-system outputs (for development shells, etc.)
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in {
        formatter = nixpkgs.legacyPackages.${system}.nixfmt-tree;
        devShells = {
          default = pkgs.mkShell {
            packages = with pkgs; [ stylua lua-language-server ];
          };
        };
      });
}
