{ ... }:

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
  boot.tmp = {
    useTmpfs = true;
    cleanOnBoot = true;
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
}
