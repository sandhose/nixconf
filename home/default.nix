{ config, pkgs, ... }:

{
  home-manager.users.sandhose = { pkgs, ... }: {
    home = import ./home.nix { inherit pkgs; };
    programs = import ./programs.nix { inherit pkgs; };
  };
}
