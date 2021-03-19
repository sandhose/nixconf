{ config, lib, ... }:

{
  imports = [ ../../profiles/base ../../profiles/container ];

  networking.hostName = "plex";

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "plexmediaserver" ];

  services.plex = {
    enable = true;
    openFirewall = true;
  };
}
