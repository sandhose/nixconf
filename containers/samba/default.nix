{ config, ... }:

{
  imports = [ ../../profiles/base ../../profiles/container ];

  networking.hostName = "samba";

  services.samba = { enable = true; };
}
