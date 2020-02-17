{ config, pkgs, ... }:

{
  home-manager.users.sandhose = { pkgs, ... }: {
    imports = [ ./modules/npm.nix ];
    home = import ./home.nix { inherit pkgs; inherit config; };
    programs = import ./programs.nix { inherit pkgs; };
  };
}
