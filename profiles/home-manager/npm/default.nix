{ config, pkgs, lib, ... }:

{
  imports = [ ./module.nix ];

  programs = {
    npm = {
      enable = true;
      package = pkgs.nodejs-15_x;
      npmrc = {
        enable = true;
        # followXDG = true;
      };

      prefix = ".local/lib/node_modules";
    };
  };
}
