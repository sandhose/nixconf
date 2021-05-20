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

  nixpkgs.overlays = [
    (
      self: super: {
        # Change pkgs.rust-analyzer with the one from fenix
        rust-analyzer = self.fenix.rust-analyzer;
      }
    )
  ];

  environment = {
    systemPackages = with pkgs; [
      clang
      clang-manpages
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

      (
        with fenix;
        combine (
          with stable; [
            cargo
            clippy-preview
            rust-std
            rustc
            rustfmt-preview
            rust-src
          ]
        )
      )
    ];
  };

  networking.firewall.allowedTCPPorts = [ 24642 ];
  networking.firewall.allowedUDPPorts = [ 24642 ];
}
