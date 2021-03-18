{ pkgs, config, lib, inputs, ... }:

let
  inherit (inputs) self nur nixpkgs;

in
{
  imports = [ ./nix.nix ./cachix.nix ./fonts.nix ];

  nixpkgs.overlays = [ self.overlay nur.overlay ];
  nix.registry.nixpkgs.flake = nixpkgs;

  environment = { systemPackages = import ./packages.nix { inherit pkgs; }; };

  nixpkgs.config = {
    allowBroken = true;
    allowUnsupportedSystem = true;
    allowUnfree = true;
  };

  programs = {
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
    zsh.enable = true;
  };
}
