{ config, lib, ... }:

{
  imports = [ ../base ];

  networking.hostName = "plex";

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "plexmediaserver" ];

  services.plex = {
    enable = true;
    openFirewall = true;
  };
}
