{ config, ... }:

{
  imports = [ ../../profiles/base ../../profiles/container ];

  networking.hostName = "transmission";

  services.transmission = {
    enable = true;
    openFirewall = true;
  };
}
