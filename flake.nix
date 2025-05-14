{
  description = "dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, utils, home-manager }:
    let
      mkHomeConfiguration =
        { hostname, system ? "x86_64-linux", stateVersion ? "24.11" }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          extraSpecialArgs = { inherit system hostname; };
          modules = [
            ./nix/common/users/simon
            {
              home = {
                username = "simon";
                homeDirectory = "/home/simon";
                inherit stateVersion;
              };
              programs.home-manager.enable = true;
              targets.genericLinux.enable = true;
            }
          ];
        };
    in {
      # Home manager configurations
      homeConfigurations = {
        "kale" = mkHomeConfiguration { hostname = "kale"; };
        "sugarsnap" = mkHomeConfiguration {
          hostname = "sugarsnap";
          stateVersion = "24.05";
        };
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
        devShells = {
          default = pkgs.mkShell {
            packages = with pkgs; [ stylua lua-language-server ];
          };
        };
      });
}
