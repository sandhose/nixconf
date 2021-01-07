{ pkgs, ... }:

{
  services.syncthing = {
    enable = pkgs.stdenv.isLinux;
    tray = true;
  };
}
