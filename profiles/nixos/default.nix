{ pkgs, inputs, lib, ... }:

with inputs; {
  imports = [
    ./amd.nix
    ./base.nix
    ./dbus-dev.nix
    ./docker.nix
    ./desktop.nix
    ./efi.nix
    ./host.nix
    ./libvirt.nix
    # ./nvidia.nix
    ./pipewire.nix
    ./wireless.nix
    ./zfs.nix
  ];

  boot.supportedFilesystems = [ "ntfs" "xfs" ];
  boot.cleanTmpDir = true;
  boot.tmpOnTmpfs = true;

  environment = {
    systemPackages = with pkgs; [
      llvmPackages_latest.bintools
      llvmPackages_latest.clang
      llvmPackages_latest.clang-manpages
      clang-tools
      darktable
      flatpak-builder
      gcc
      gnome3.gnome-tweaks
      gnome-builder
      google-chrome
      keepassxc
      libtool
      manpages
      minecraft
      mumble
      # signal-desktop
      # steam
      # teams
      vlc
      zoom-us

      fenix.rust-analyzer
    ];
  };

  networking.firewall.allowedTCPPorts = [ 24642 8080 ];
  networking.firewall.allowedUDPPorts = [ 24642 ];
}
