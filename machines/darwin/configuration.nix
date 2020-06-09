{ config, pkgs, lib, ... }:

{
  imports = [
    <home-manager/nix-darwin>
    ../../common
  ];
  environment = import ./environment.nix { inherit pkgs; };
  programs = {
    nix-index.enable = true;
  };
  nix = import ./nix.nix { inherit pkgs; inherit lib; };
  system = import ./system.nix;

  users.users = {
    sandhose = {
      description = "Quentin Gliech";
      shell = pkgs.zsh;
      home = "/Users/sandhose";
    };
  };

  services.nix-daemon.enable = true;
}
