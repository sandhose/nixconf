{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      darwin,
      flake-utils,
      home-manager,
      lanzaboote,
      nixos-generators,
      nixpkgs,
    }@inputs:
    (flake-utils.lib.eachDefaultSystem (
      system:
      let
        systemPkgs = import nixpkgs { inherit system; };
      in
      {
        packages = import ./packages { nixpkgs = systemPkgs; };
        devShells.default =
          with systemPkgs;
          mkShell {
            nativeBuildInputs = [
              nixos-generators.packages.${system}.nixos-generate
              nixfmt
            ];
          };
      }
    ))
    // {
      overlays.default = (final: prev: { my = self.packages.${final.stdenv.hostPlatform.system}; });

      darwinConfigurations."sandhose-laptop" = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        inherit inputs;
        modules = [
          # This needs to be imported here because of some weird infinite recursions issues
          home-manager.darwinModules.home-manager
          ./hosts/sandhose-laptop
        ];
      };

      darwinConfigurations."sandhose-laptop-m1" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        inherit inputs;
        modules = [
          # This needs to be imported here because of some weird infinite recursions issues
          home-manager.darwinModules.home-manager
          ./hosts/sandhose-laptop
        ];
      };

      darwinConfigurations."quenting-laptop" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        inherit inputs;
        modules = [
          # This needs to be imported here because of some weird infinite recursions issues
          home-manager.darwinModules.home-manager
          ./hosts/quenting-laptop
        ];
      };

      nixosConfigurations = {
        "sandhose-desktop" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/sandhose-desktop ];
        };

        "spaetzle" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/spaetzle ];
        };
      };
    };
}
