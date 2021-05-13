{ inputs, pkgs, ... }:

let inherit (inputs) self rycee nixpkgs nix;

in {
  imports = [ ./cachix.nix ./nix.nix ];

  nixpkgs.overlays = [
    self.overlay
    nix.overlay
    (final: prev: {
      firefox-addons = (import rycee { pkgs = prev; }).firefox-addons;
    })
  ];

  nix.registry.nixpkgs.flake = nixpkgs;
}
