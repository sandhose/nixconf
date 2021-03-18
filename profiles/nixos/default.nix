{ pkgs, inputs, lib, ... }:

with inputs; {
  imports =
    [ nixpkgs.nixosModules.notDetected home-manager.nixosModules.home-manager ];

  boot = {
    supportedFilesystems = [ "zfs" "ntfs" "xfs" ];

    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
        memtest86.enable = true;
      };
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_latest;

    extraModprobeConfig = ''
      options hid_apple iso_layout=0
    '';
    kernelParams = [ "amd_iommu=on" "pcie_aspm=off" ];
    kernelModules = [ "vfio-pci" "kvm-amd" ];
    blacklistedKernelModules = [ "nouveau" ];
  };

  environment = {
    systemPackages = with pkgs; [
      clang
      clang-manpages
      clang-tools
      citrix_workspace
      darktable
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
      manpages
      minecraft
      mumble
      signal-desktop
      steam
      teams
      virt-manager
      vlc
      zoom-us
    ];
  };

  services = {
    openssh.enable = true;
    fwupd.enable = true;
    flatpak.enable = true;
    zfs = {
      autoSnapshot.enable = true;
      trim.enable = true;
      autoScrub.enable = true;
    };
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome3.enable = true;
      libinput.enable = true;
      layout = "fr";
      xkbModel = "pc105";
      xkbVariant = "mac";

      videoDrivers = [ "nvidia" ];
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    resolved.enable = true;
  };

  security = {
    # Pipewire uses this
    rtkit.enable = true;
    apparmor.enable = true;
    auditd.enable = true;

    pam.loginLimits = [
      { domain = "@audio"; item = "memlock"; type = "soft"; value = "64"; }
      { domain = "@audio"; item = "memlock"; type = "hard"; value = "128"; }
    ];
  };

  systemd.user.services.pipewire.serviceConfig.LimitMEMLOCK = "131072";

  console.useXkbConfig = true;

  networking.firewall.allowedTCPPorts = [ 22 2376 9200 24642 ];
  networking.firewall.allowedUDPPorts = [ 24642 ];
  virtualisation.docker = {
    enable = true;
    listenOptions = [ "/run/docker.sock" "[::]:2376" ];
    extraOptions = "--experimental";
  };

  environment.etc."docker/daemon.json".text = builtins.toJSON {
    features.buildkit = true;
  };

  virtualisation.libvirtd = {
    enable = true;
    qemuOvmf = true;
  };
  virtualisation.spiceUSBRedirection.enable = true;

  systemd.tmpfiles.rules =
    [ "f /dev/shm/looking-glass 0660 sandhose qemu-libvirtd -" ];

  hardware = {
    # Explicitely disable pulseaudio, because we are using pipewire
    pulseaudio.enable = false;
    steam-hardware.enable = true;
    opengl = {
      driSupport32Bit = true;
      extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    };
    cpu.amd.updateMicrocode = true;
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    bluetooth = {
      enable = true;
      package = pkgs.bluezFull;
      hsphfpd.enable = true;
    };
  };

  fonts.fontDir.enable = true;
  time.timeZone = "Europe/Paris";

  nixpkgs.overlays = [ (self: super: {
    sandhose-dbus = super.writeTextFile {
      name = "sandhose-dbus";
      destination = "/share/dbus-1/system.d/fr.sandhose.conf";
      text = ''
        <!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
          "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
        <busconfig>
          <policy user="sandhose">
            <allow own_prefix="fr.sandhose"/>
            <allow send_destination="fr.sandhose"/>
          </policy>

          <policy context="default">
            <allow send_destination="fr.sandhose.Player"/>
          </policy>
        </busconfig>
      '';
    };
  }) ];

  services.dbus.packages = [ pkgs.sandhose-dbus ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?

  system.configurationRevision = lib.mkIf (self ? rev) self.rev;
}
