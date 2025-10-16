{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [ ./module.nix ];

  programs = {
    npm = {
      enable = true;
      package = pkgs.nodejs_22;
      npmrc = {
        enable = true;
        # followXDG = true;
      };

      prefix = ".local";
    };
  };
}
