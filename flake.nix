{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, darwin, nixpkgs, home-manager, flake-utils }:
    (flake-utils.lib.eachDefaultSystem (system:
    let systemPkgs = import nixpkgs { inherit system; };
    in {
      packages = import ./packages { nixpkgs = systemPkgs; };
    })) // {
      overlay = (final: prev: {
        my = self.packages.${final.system};
      });

      darwinConfigurations."sandhose-laptop" = darwin.lib.darwinSystem {
        inputs = { my = self; };
        modules = [
          ./common
          ./darwin
          home-manager.darwinModules.home-manager
        ];
      };
    };
}
