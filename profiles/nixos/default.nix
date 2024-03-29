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
  boot.tmp = {
    useTmpfs = true;
    cleanOnBoot = true;
  };

  environment = {
    systemPackages = with pkgs; [
      llvmPackages_latest.bintools
      llvmPackages_latest.clang
      llvmPackages_latest.clang-manpages
      clang-tools
      #darktable
      flatpak-builder
      gcc
      gnome.gnome-tweaks
      gnome-builder
      google-chrome
      keepassxc
      libtool
      man-pages
      minecraft
      mumble
      # signal-desktop
      # steam
      # teams
      vlc
      zoom-us
    ];
  };

  networking.firewall.allowedTCPPorts = [
    24642
    8080
    8008
    # Unifi
    53
    8443
    8880
    8843
    6789
    27117
  ];
  networking.firewall.allowedUDPPorts = [
    24642
    # unifi
    53
    3478
    5514
    10001
    1900
    123
  ];
}
