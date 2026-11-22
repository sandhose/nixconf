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

      # sqlx-cli links against system sqlite but doesn't list it as a dependency: https://github.com/NixOS/nixpkgs/pull/585098
      sqlx-cli = prev.sqlx-cli.overrideAttrs (old: {
        buildInputs = (old.buildInputs or [ ]) ++ [ final.sqlite ];
      });

      # rustaceanvim integration tests time out waiting for rust-analyzer on darwin: https://github.com/NixOS/nixpkgs/issues/588378
      luajit =
        if prev.stdenv.hostPlatform.isDarwin then
          prev.luajit.override {
            packageOverrides = lfinal: lprev: {
              rustaceanvim = lprev.rustaceanvim.overrideAttrs { doCheck = false; };
            };
          }
        else
          prev.luajit;
    })
  ];

  #nix.registry.nixpkgs.flake = nixpkgs;
}
