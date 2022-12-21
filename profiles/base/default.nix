{ inputs, pkgs, ... }:

let inherit (inputs) self rycee nixpkgs fenix;

in
{
  imports = [ ./cachix-adapter.nix ./nix.nix ];

  nixpkgs.overlays = [
    self.overlay
    fenix.overlays.default
    (final: prev: {
      nix-direnv = prev.nix-direnv.override { enableFlakes = true; };
    })
    (final: prev: {
      inherit ((import rycee { pkgs = prev; })) firefox-addons;
    })
    # TEMP FIX for https://github.com/NixOS/nixpkgs/issues/206958
    (final: prev: {
      clisp = prev.clisp.override {
        # On newer readline8 fails as:
        #  #<FOREIGN-VARIABLE "rl_readline_state" #x...>
        #   does not have the required size or alignment
        readline = pkgs.readline6;
      };
    })
    (final: prev:
      let
        inherit (prev) config;
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
