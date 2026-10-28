{ inputs, ... }:

let
  inherit (inputs) self jj-starship;

in
{
  imports = [
    ./cachix-adapter.nix
    ./nix.nix
  ];

  nixpkgs.overlays = [
    self.overlays.default
    jj-starship.overlays.default

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

      # FIXME: TEMPORARY WORKAROUND, REMOVE once nixpkgs fixes redis on darwin.
      # redis 8.10.3 no longer has the SDK path in src/modules/Makefile, so the darwin
      # --replace-fail in postPatch aborts the build (broken since NixOS/nixpkgs#579205).
      # This blanket-swaps every --replace-fail in postPatch, so it hides future
      # substitution breakages in redis too; check the upstream derivation before keeping it.
      redis = prev.redis.overrideAttrs (old: {
        postPatch = builtins.replaceStrings [ "--replace-fail" ] [ "--replace-quiet" ] old.postPatch;
      });
    })
  ];

  #nix.registry.nixpkgs.flake = nixpkgs;
}
