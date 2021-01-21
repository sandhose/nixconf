{ config, pkgs, lib, ... }:

{
  imports = [ ./module.nix ];

  programs = {
    npm = {
      enable = true;
      npmrc = {
        enable = true;
        # followXDG = true;
      };

      prefix = ".local/lib/node_modules";
    };
  };
}
