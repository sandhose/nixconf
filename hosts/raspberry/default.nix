{ inputs, lib, ... }:

let inherit (inputs) nixpkgs;

in
{
  imports = [
    ../../profiles/sd-card/sd-image-aarch64.nix
    ../../profiles/base
    ../../profiles/nixos/base.nix
    ../../profiles/nixos/host.nix
    ../../users/root/nixos.nix
    ../../users/sandhose/nixos.nix
  ];

  networking = {
    hostId = "c300d1cf";
    hostName = "raspberry";
  };
}
