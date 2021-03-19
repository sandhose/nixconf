{ inputs, ... }:

with inputs;

let
  systemPath = name:
    self.nixosConfigurations.${name}.config.system.build.toplevel;

in {
  imports = [ ../../profiles/base ../../profiles/container ];

  boot.enableContainers = true;
  networking.hostName = "spaetzle";
  boot.kernel.sysctl."net.ipv4.ip_forward" = "1";

  containers = {
    murmur = {
      path = systemPath "murmur";
      autoStart = true;
      privateNetwork = true;
      hostAddress = "10.42.5.1";
      localAddress = "10.42.5.2";
    };

    transmission = {
      path = systemPath "transmission";
      autoStart = true;
      privateNetwork = true;
      hostAddress = "10.42.5.3";
      localAddress = "10.42.5.4";
    };

    minecraft = {
      path = systemPath "minecraft";
      autoStart = true;
      privateNetwork = true;
      hostAddress = "10.42.5.5";
      localAddress = "10.42.5.6";
    };

    plex = {
      path = systemPath "plex";
      autoStart = true;
      privateNetwork = true;
      hostAddress = "10.42.5.7";
      localAddress = "10.42.5.8";
    };

    samba = {
      path = systemPath "samba";
      autoStart = true;
      privateNetwork = true;
      hostAddress = "10.42.5.9";
      localAddress = "10.42.5.10";
    };
  };
}
