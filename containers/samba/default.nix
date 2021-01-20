{ config, ... }:

{
  imports = [ ../base ];

  networking.hostName = "samba";

  services.samba = { enable = true; };
}
