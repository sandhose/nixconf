{ inputs, ... }:

let inherit (inputs) self nur nixpkgs;

in {
  imports = [ ./cachix.nix ./nix.nix ];

  nixpkgs.overlays = [ self.overlay nur.overlay ];
  nix.registry.nixpkgs.flake = nixpkgs;
}
