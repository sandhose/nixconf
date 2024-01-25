{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix = {
      url = "github:NixOS/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , darwin
    , fenix
    , flake-utils
    , home-manager
    , nix
    , nixos-generators
    , nixpkgs
    , rycee
    , sops-nix
    }@inputs:
    (flake-utils.lib.eachDefaultSystem (system:
    let systemPkgs = import nixpkgs { inherit system; };
    in
    {
      packages = import ./packages { nixpkgs = systemPkgs; };
      devShell = with systemPkgs;
        mkShell {
          sopsPGPKeyDirs = [ "./keys" ];
          nativeBuildInputs = [
            sops-nix.packages.${system}.sops-import-keys-hook
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
        "home-assistant"
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
