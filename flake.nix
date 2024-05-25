{
  inputs = {
    flake-utils.url = "https://flakehub.com/f/numtide/flake-utils/0.1.tar.gz";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix = {
      url = "https://flakehub.com/f/NixOS/nix/2.21.2.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "flake-compat";
    };

    fenix = {
      url = "https://flakehub.com/f/nix-community/fenix/0.1.1822.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-compat.url = "https://flakehub.com/f/edolstra/flake-compat/1.0.1.tar.gz";

    rycee = {
      url = "gitlab:rycee/nur-expressions";
      flake = false;
    };

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-generators = {
      url = "https://flakehub.com/f/nix-community/nixos-generators/0.1.390.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , darwin
    , fenix
    , flake-utils
    , flake-compat
    , home-manager
    , nix
    , nixos-generators
    , nixpkgs
    , rycee
    }@inputs:
    (flake-utils.lib.eachDefaultSystem (system:
    let systemPkgs = import nixpkgs { inherit system; };
    in
    {
      packages = import ./packages { nixpkgs = systemPkgs; };
      devShell = with systemPkgs;
        mkShell {
          nativeBuildInputs = [
            nixos-generators.packages.${system}.nixos-generate
            nixfmt
          ];
        };
    })) // {
      overlay = (final: prev: { my = self.packages.${final.system}; });

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

      nixosConfigurations = (nixpkgs.lib.genAttrs [
        "minecraft"
        "murmur"
        "plex"
        "samba"
        "transmission"
      ]
        (name:
          nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [ (./containers + "/${name}") ];
          })) // {
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

        "raspberry" = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/raspberry ];
        };

        "vpn" = nixpkgs.lib.makeOverridable nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/vpn ];
        };

        "live" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/live ];
        };
      };
    };
}
