{ inputs, pkgs, ... }:

let inherit (inputs) self rycee nixpkgs fenix;

in
{
  imports = [ ./cachix-adapter.nix ./nix.nix ];

  nixpkgs.overlays = [
    self.overlay
    fenix.overlay
    (final: prev: {
      nix-direnv = prev.nix-direnv.override { enableFlakes = true; };
    })
    (final: prev: {
      firefox-addons = (import rycee { pkgs = prev; }).firefox-addons;
    })
    (final: prev:
      let
        config = prev.config;
        x86Pkgs = import nixpkgs {
          inherit config;
          localSystem = "x86_64-darwin";
        };
      in
      if prev.stdenv.system == "aarch64-darwin" then {
        inherit (x86Pkgs) xquartz nix-index wrk;
      } else
        { })
  ];

  nix.registry.nixpkgs.flake = nixpkgs;
}
