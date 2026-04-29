{ inputs, ... }:

let
  inherit (inputs) self;

in
{
  imports = [
    ./cachix-adapter.nix
    ./nix.nix
  ];

  nixpkgs.overlays = [
    self.overlays.default

    (final: prev: {
      # Nomad tests are failing on darwin in CI and often failing because of disk space requirements on Linux
      nomad = prev.nomad.overrideAttrs (old: {
        doCheck = false;
        doInstallCheck = false;
      });

      # direnv tests are failing on darwin: https://github.com/NixOS/nixpkgs/issues/507531
      direnv = prev.direnv.overrideAttrs (old: {
        doCheck = false;
      });
    })
  ];

  #nix.registry.nixpkgs.flake = nixpkgs;
}
