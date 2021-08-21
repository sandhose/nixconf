{ inputs, lib, ... }:

with inputs;

let
  systemPath = name:
    self.nixosConfigurations.${name}.config.system.build.toplevel;

  genAddr = num:
    {
      privateNetwork = true;
      hostAddress = "10.42.5.${num * 2 + 1}";
      localAddress = "10.42.5.${num * 2 + 2}";
      hostAddress6 = "2a01:e34:ec48:3616::1:${lib.trivial.toHexString (num * 2 + 1)}";
      localAddress6 = "2a01:e34:ec48:3616::1:${lib.trivial.toHexString (num * 2 + 2)}";
    };
  peer = num: publicKey: {
    inherit publicKey;
    allowedIPs = [ "10.42.6.${num}/32" "2a01:e34:ec48:3616::2:${lib.trivial.toHexString num}/128" ];
  };

in
{
  imports = [
    ../../profiles/base
    ../../profiles/common
    ../../profiles/home-manager
    ../../profiles/nixos/base.nix
    ../../profiles/nixos/host.nix
    ../../profiles/nixos/efi.nix
    ../../profiles/nixos/zfs.nix
  ];

  boot.enableContainers = true;
  networking = {
    hostId = "c47b7531";
    hostName = "spaetzle";
  };
  boot.kernel.sysctl."net.ipv4.ip_forward" = "1";
  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;

  containers = {
    murmur = {
      path = systemPath "murmur";
      autoStart = true;
    } // genAddr 1;

    transmission = {
      path = systemPath "transmission";
      autoStart = true;
    } // genAddr 2;

    minecraft = {
      path = systemPath "minecraft";
      autoStart = true;
    } // genAddr 3;

    plex = {
      path = systemPath "plex";
      autoStart = true;
    } // genAddr 4;

    samba = {
      path = systemPath "samba";
      autoStart = true;
    } // genAddr 5;
  };

  fileSystems."/" = {
    device = "rpool/system/root";
    fsType = "zfs";
  };

  fileSystems."/var" = {
    device = "rpool/system/root";
    fsType = "zfs";
  };

  fileSystems."/home" = {
    device = "rpool/user";
    fsType = "zfs";
  };

  fileSystems."/home/sandhose" = {
    device = "rpool/user/sandhose";
    fsType = "zfs";
  };

  fileSystems."/nix" = {
    device = "rpool/local/nix";
    fsType = "zfs";
  };


  fileSystems."/boot" = {
    device = "/dev/disk/by-partlabel/efi";
    fsType = "vfat";
  };


  networking.wireguard = {
    enable = false; # We need a private key, let's skip that for now
    interfaces.wg0 = {
      ips = [ "10.42.6.255/24" "2a01:e34:ec48:3616::2:ffff/112" ];
      listenPort = 51820;
      allowedIPsAsRoutes = false; # Let's rely on iface IPs instead of peers allowedIPs
      peers = [
        (peer 1 "Cb665kMFY7Im8bj4bgnn/TUWVWA6s4FfKnJOAUHm1Wc=") # sandhose-laptop
      ];
    };
  };
}
