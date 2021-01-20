{ pkgs, ... }:

{
  services.syncthing = { enable = pkgs.stdenv.isLinux; };
}
