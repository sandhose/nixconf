{ inputs, ... }:

let
  inherit (inputs) self fenix;

in
{
  imports = [
    ./cachix-adapter.nix
    ./nix.nix
  ];

  nixpkgs.overlays = [
    self.overlay
    fenix.overlays.default
    # Nomad tests are failing on darwin in CI and often failing because of disk space requirements on Linux
    (final: prev: {
      nomad = prev.nomad.overrideAttrs (old: {
        doCheck = false;
        doInstallCheck = false;
      });
    })
  ];

  #nix.registry.nixpkgs.flake = nixpkgs;
}
