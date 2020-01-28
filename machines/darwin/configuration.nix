{ config, pkgs, ... }:

{
  imports = [
    <home-manager/nix-darwin>
    ../../common
  ];
  environment = import ./environment.nix { inherit pkgs; };
  programs = import ./programs.nix;
  nix = import ./nix.nix { inherit pkgs; };
  # nixpkgs = import ./nixpkgs.nix;
  system = import ./system.nix;

  users.users = {
    sandhose = {
      description = "Quentin Gliech";
      shell = pkgs.zsh;
      home = "/Users/sandhose";
    };
  };

  home-manager.users.sandhose = { pkgs, ... }: {
    home = import ../../home/home.nix { inherit pkgs; };
    programs = import ../../home/programs.nix { inherit pkgs; };
  };

  fonts.fonts = with pkgs; [
    fira-code
  ];

  services.nix-daemon.enable = true;
}
