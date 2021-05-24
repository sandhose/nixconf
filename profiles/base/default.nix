{ inputs, pkgs, ... }:

let inherit (inputs) self rycee nixpkgs fenix neovim;

in {
  imports = [ ./cachix.nix ./nix.nix ];

  nixpkgs.overlays = [
    self.overlay
    fenix.overlay
    neovim.overlay
    (final: prev: {
      firefox-addons = (import rycee { pkgs = prev; }).firefox-addons;
    })
  ];

  nix.registry.nixpkgs.flake = nixpkgs;
}
