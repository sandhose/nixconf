{ config, ... }:

{
  imports = [ ../base ];

  networking.hostName = "transmission";

  services.transmission = {
    enable = true;
    openFirewall = true;
  };
}
