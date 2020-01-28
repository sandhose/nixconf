{ config, pkgs, ... }:

{
  imports = [
    <home-manager/nix-darwin>
    ../../common
  ];
  environment = import ./environment.nix { inherit pkgs; };
  programs = {
    nix-index.enable = true;
  };
  nix = import ./nix.nix { inherit pkgs; };
  system = import ./system.nix;

  users.users = {
    sandhose = {
      description = "Quentin Gliech";
      shell = pkgs.zsh;
      home = "/Users/sandhose";
    };
  };

  fonts.fonts = with pkgs; [
    fira-code
  ];

  services.nix-daemon.enable = true;
}
