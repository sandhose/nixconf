{ config, lib, ... }:

{
  imports = [ ../../profiles/base ../../profiles/container ];

  networking.hostName = "minecraft";

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "minecraft-server" ];

  services.minecraft-server = {
    enable = true;
    eula = true;
    openFirewall = true;
  };
}
