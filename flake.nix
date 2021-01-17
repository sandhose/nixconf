{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    sops-nix.url = "github:Mic92/sops-nix";
    darwin-compat.url = "github:sandhose/nix-darwin-compat";

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, darwin, nixpkgs, home-manager, sops-nix, flake-utils, nur, darwin-compat }@inputs:
    (flake-utils.lib.eachDefaultSystem (system:
    let systemPkgs = import nixpkgs { inherit system; };
    in {
      packages = import ./packages { nixpkgs = systemPkgs; };
      devShell = with systemPkgs; mkShell {
        sopsPGPKeyDirs = [ "./keys" ];
        nativeBuildInputs = [
          sops-nix.packages.${system}.sops-pgp-hook
        ];
      };
    })) // {
      overlay = (final: prev: {
        my = self.packages.${final.system};
      });

      darwinConfigurations."sandhose-laptop" = darwin.lib.darwinSystem {
        modules = [
          ./common
          ./darwin
          home-manager.darwinModules.home-manager
          darwin-compat.darwinModules.flake-registry
        ];
        inputs = inputs;
      };

      nixosConfigurations."sandhose-desktop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };

        modules = [
          ./common
          ./nixos
          ./hosts/sandhose-desktop
          nixpkgs.nixosModules.notDetected
          home-manager.nixosModules.home-manager
        ];
      };

      nixosConfigurations."murmur" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };

        modules = [
          ./containers/base
          ./containers/murmur 
        ];
      };

      nixosConfigurations."home-assistant" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };

        modules = [
          ./containers/base
          ./containers/home-assistant
          sops-nix.nixosModules.sops
        ];
      };
    };
}
