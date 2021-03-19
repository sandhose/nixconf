{ config, ... }:

{
  imports = [ ../../profiles/container ];

  networking.hostName = "murmur";

  networking.firewall.allowedTCPPorts = [ config.services.murmur.port ];
  networking.firewall.allowedUDPPorts = [ config.services.murmur.port ];

  services.murmur = { enable = true; };
}
