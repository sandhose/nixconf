{
  pkgs,
  lib,
  config,
  ...
}:

{
  imports = [
    ../../profiles/base
    ../../profiles/common
    ../../profiles/nixos
    ../../profiles/nixos/lanzaboote.nix
    ../../profiles/nixos/credentialsd.nix
    ../../profiles/home-manager
    ../../users/sandhose/nixos-gui.nix
    ../../users/root/nixos.nix
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ehci_pci"
    "nvme"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [
    "kvm-amd" # "r8125"
  ];
  # boot.extraModulePackages = [ config.boot.kernelPackages.r8125 ];

  networking = {
    hostName = "sandhose-desktop";
    hostId = "f61bc842";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-partlabel/root";
    fsType = "xfs";
  };

  fileSystems."/home" = {
    device = "rpool/safe/home";
    fsType = "zfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-partlabel/efi";
    fsType = "vfat";
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 32768;
    }
  ];

  # Personal Rex server, reachable on the tailnet through Rex's own embedded
  # Tailscale node at https://rex-desktop.<tailnet>.ts.net
  home-manager.users.sandhose.services.rex = {
    enable = true;
    tailscale = {
      enable = true;
      hostname = "rex-desktop";
    };
  };
  # Keep the user service (and its sessions) alive while logged out
  users.users.sandhose.linger = true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "schedutil";
}
