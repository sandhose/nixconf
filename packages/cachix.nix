{ pkgs, ... }:

# Cachix has issue building with nixUnstable
pkgs.cachix.overrideAttrs (attrs: {
  nix = pkgs.nixStable;
})
