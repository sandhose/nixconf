{ pkgs, lib, ... }:

{
  imports = [
    ../../profiles/common
    ../../profiles/nixos
    ../../profiles/home-manager
    ../../users/sandhose/nixos-gui.nix
    ../../users/root/nixos.nix
  ];

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ehci_pci" "nvme" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

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

  swapDevices = [ ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
