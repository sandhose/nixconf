{ inputs, lib, pkgs, ... }:

let
  inherit (inputs) nixpkgs;

in
{
  imports = [
    ../../profiles/base
    ../../profiles/nixos/base.nix
    ../../profiles/nixos/host.nix
    # ../../users/root/nixos.nix
  ];

  networking = {
    hostId = "550b1c06";
    hostName = "vpn";
  };
}
