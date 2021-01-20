{ config, ... }:

{
  networking.firewall.allowedTCPPorts = [ config.services.murmur.port ];
  networking.firewall.allowedUDPPorts = [ config.services.murmur.port ];

  services.murmur = { enable = true; };
}
