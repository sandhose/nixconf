{ config, pkgs, lib, ... }:

{
  imports = [ ./module.nix ];

  programs = {
    npm = {
      enable = true;
      package = pkgs.nodejs_latest;
      npmrc = {
        enable = true;
        # followXDG = true;
      };

      prefix = ".local/lib/node_modules";
    };
  };
}
