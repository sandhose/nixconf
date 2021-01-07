{ pkgs, inputs, lib, ... }:

{
  boot = {
    supportedFilesystems = [ "zfs" ];

    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
        memtest86.enable = true;
      };
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;

    # extraModprobeConfig = ''
    #   options vfio-pci ids=10de:11c0,10de:0e0b
    # '';
    kernelParams = [ "amd_iommu=on" "pcie_aspm=off" ];
    kernelModules = [ "vfio-pci" "kvm-amd" ];
    blacklistedKernelModules = [ "nouveau" ];
  };

  environment = {
    systemPackages =
      with pkgs; [
        clang
        clang-manpages
        clang-tools
        flatpak-builder
        gcc
        gnome3.gnome-tweaks
        gnome3.gnome-boxes
        gnome-builder
        google-chrome
        keepassxc
        libtool
        libvirt
        looking-glass-client
        mumble
        steam
        virt-manager
        vlc
        zoom-us
      ];
  };

  services = {
    openssh.enable = true;
    fwupd.enable = true;
    flatpak.enable = true;
  };

  networking.firewall.allowedTCPPorts = [ 22 2376 ];
  virtualisation.docker = {
    enable = true;
    listenOptions = [
      "/run/docker.sock"
      "[::]:2376"
    ];
    extraOptions = "--experimental";
  };
  virtualisation.libvirtd = {
    enable = true;
    qemuOvmf = true;
  };
  virtualisation.spiceUSBRedirection.enable = true;

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 sandhose qemu-libvirtd -"
  ];

  sound.enable = true;
  hardware = {
    pulseaudio = {
      enable = true;
      support32Bit = true;
    };
    opengl = {
      driSupport32Bit = true;
      extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    };
    cpu.amd.updateMicrocode = true;
  };

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome3.enable = true;
    libinput.enable = true;
    layout = "fr";
    xkbModel = "pc105";
    xkbVariant = "mac";

    videoDrivers = [ "nvidia" ];
  };

  fonts.fontDir.enable = true;

  users = {
    groups.sandhose = { };
    users.sandhose = {
      description = "Quentin Gliech";
      isNormalUser = true;
      group = "sandhose";
      home = "/home/sandhose";
      shell = pkgs.zsh;
      extraGroups = [ "wheel" "docker" "libvirtd" "kvm" "dialout" ];

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKI3JrkOofavtPW8jV/GYM5Mv1gn/h732JPm82SGGj50 sandhose@sandhose-laptop"
      ];
    };
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?

  system.configurationRevision = lib.mkIf (inputs.self ? rev) inputs.self.rev;
}
