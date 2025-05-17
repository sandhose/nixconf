{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # gnome.gnome-boxes
    libvirt
    #looking-glass-client
    # virt-manager -- TODO spice-gtk is not building, will be fixed soon
  ];

  virtualisation.libvirtd = {
    enable = true;
    qemu.ovmf.enable = true;
  };
  # virtualisation.spiceUSBRedirection.enable = true; TODO

  systemd.tmpfiles.rules = [ "f /dev/shm/looking-glass 0660 sandhose qemu-libvirtd -" ];

  # for PCIe forwarding
  boot = {
    kernelParams = [ "pcie_aspm=off" ];
    kernelModules = [ "vfio-pci" ];
  };
}
