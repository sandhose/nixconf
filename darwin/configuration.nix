{ config, pkgs, ... }:

{
  environment = import ../config/environment.nix { inherit pkgs; };
  programs = import ../config/programs.nix;
  nix = import ../config/nix.nix { inherit pkgs; };
  nixpkgs = import ../config/nixpkgs.nix;
  system = import ../config/system.nix;

  fonts.fonts = with pkgs; [
    fira-code
  ];

  services.nix-daemon.enable = true;
}
