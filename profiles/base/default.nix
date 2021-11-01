{ inputs, pkgs, ... }:

let inherit (inputs) self firefox-addons nixpkgs fenix neovim;

in
{
  imports = [ ./cachix.nix ./nix.nix ];

  nixpkgs.overlays = [
    self.overlay
    fenix.overlay
    neovim.overlay
    (final: prev: {
      firefox-addons = firefox-addons.packages."${prev.stdenv.system}";
    })
    (final: prev:
      let
        config = prev.config;
        x86Pkgs = import nixpkgs { inherit config; localSystem = "x86_64-darwin"; };
      in
      if prev.stdenv.system == "aarch64-darwin" then {
        inherit (x86Pkgs) xquartz nix-index wrk;
      } else { })
  ];

  nix.registry.nixpkgs.flake = nixpkgs;
}
