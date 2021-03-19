{ config, ... }:

{
  imports = [ ../../profiles/container ];

  networking.hostName = "samba";

  services.samba = { enable = true; };
}
