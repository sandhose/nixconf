{ pkgs, config, lib, inputs, ... }:

{
  imports = [
    ./nix.nix
    ./cachix.nix
    ./fonts.nix
    ../home
  ];

  nixpkgs.overlays = [ inputs.self.overlay inputs.nur.overlay ];
  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  environment = {
    systemPackages = import ./packages.nix { inherit pkgs; };
  };

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
