{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:sandhose/nixpkgs/gnome-40";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin-compat.url = "github:sandhose/nix-darwin-compat";
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
  };

  outputs = { self, darwin, nixpkgs, home-manager, sops-nix, flake-utils, rycee
    , darwin-compat }@inputs:
    (flake-utils.lib.eachDefaultSystem (system:
      let systemPkgs = import nixpkgs { inherit system; };
      in {
        packages = import ./packages { nixpkgs = systemPkgs; };
        devShell = with systemPkgs;
          mkShell {
            sopsPGPKeyDirs = [ "./keys" ];
            nativeBuildInputs =
              [ sops-nix.packages.${system}.sops-pgp-hook nixfmt ];
          };
      })) // {
        overlay = (final: prev: { my = self.packages.${final.system}; });

        darwinConfigurations."sandhose-laptop" = darwin.lib.darwinSystem {
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
        ] (name:
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
          };
      };
}
