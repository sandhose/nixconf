{ pkgs, ... }:

{
  boot = {
    supportedFilesystems = [ "zfs" ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;

    extraModprobeConfig = ''
      options kvm ignore_msrs=1 report_ignored_msrs=0
    '';
    kernelModules = [ "kvmgt" "vfio-iommu-type1" "vfio-mdev" ];
  };

  environment = {
    systemPackages =
      with pkgs; [
        clang
        clang-manpages
        clang-tools
        gnome3.gnome-tweaks
        gnome3.gnome-boxes
        google-chrome
        keepassxc
        libvirt
        mumble
        steam
        virt-manager
        vlc
      ];
  };

  nix = {
    trustedUsers = [ "@wheel" ];
    package = pkgs.nixFlakes;

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  services = {
    openssh.enable = true;
    fwupd.enable = true;
    syncthing.enable = true;
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
  virtualisation.libvirtd.enable = true;
  virtualisation.kvmgt.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

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

    videoDrivers = [ "nouveau" ];
  };

  users = {
    groups.sandhose = { };
    users.sandhose = {
      description = "Quentin Gliech";
      isNormalUser = true;
      group = "sandhose";
      home = "/home/sandhose";
      shell = pkgs.zsh;
      extraGroups = [ "wheel" "docker" "libvirtd" "kvm" "dialout" "syncthing" ];

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
}
