{ inputs, ... }:

let inherit (inputs) self rycee nixpkgs fenix;

in
{
  imports = [ ./cachix-adapter.nix ./nix.nix ];

  nixpkgs.overlays = [
    self.overlay
    fenix.overlays.default
    # Nomad tests are failing on darwin in CI and often failing because of disk space requirements on Linux
    (final: prev: {
      nomad = prev.nomad.overrideAttrs (old: {
        doChek = false;
        doInstallCheck = false;
      });
    })
    (final: prev: {
      inherit ((import rycee { pkgs = prev; })) firefox-addons;
    })
  ];

  nix.registry.nixpkgs.flake = nixpkgs;
}
