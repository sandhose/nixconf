{ inputs, ... }:

let inherit (inputs) self rycee nixpkgs;

in {
  imports = [ ./cachix.nix ./nix.nix ];

  nixpkgs.overlays = [
    self.overlay
    (final: prev: {
      firefox-addons = (import rycee { pkgs = prev; }).firefox-addons;
    })
  ];

  nix.registry.nixpkgs.flake = nixpkgs;
}
