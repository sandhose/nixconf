{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix = {
      url = "github:NixOS/nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-compat.url = "github:edolstra/flake-compat";

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
  };

  outputs =
    {
      self,
      darwin,
      fenix,
      flake-utils,
      flake-compat,
      home-manager,
      nix,
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
        devShell =
          with systemPkgs;
          mkShell {
            nativeBuildInputs = [
              nixos-generators.packages.${system}.nixos-generate
              nixfmt-rfc-style
            ];
          };
      }
    ))
    // {
      overlay = (final: prev: { my = self.packages.${final.stdenv.hostPlatform.system}; });

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
