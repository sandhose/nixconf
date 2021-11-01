{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # gnome3.gnome-boxes
    libvirt
    looking-glass-client
    virt-manager
  ];

  virtualisation.libvirtd = {
    enable = true;
    qemu.ovmf.enable = true;
  };
  virtualisation.spiceUSBRedirection.enable = true;

  systemd.tmpfiles.rules =
    [ "f /dev/shm/looking-glass 0660 sandhose qemu-libvirtd -" ];

  # for PCIe forwarding
  boot = {
    kernelParams = [ "pcie_aspm=off" ];
    kernelModules = [ "vfio-pci" ];
  };
}
