{ inputs, ... }:

let inherit (inputs) home-manager;

in {
  imports = [ ../base ../common ../nixos/base.nix ../../users/root/nixos.nix ];

  boot.isContainer = true;
  networking.useDHCP = false;
}
