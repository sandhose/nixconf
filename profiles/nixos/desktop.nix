{ pkgs, ... }:

{
  services = {
    tailscale.enable = true;
    # teamviewer.enable = true;
    flatpak.enable = true;
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      displayManager.gdm.wayland = true;
      desktopManager.gnome.enable = true;
      xkb = {
        model = "pc105";
        variant = "mac";
        layout = "fr";
      };
    };
    libinput.enable = true;

    postgresql = {
      enable = true;
      package = pkgs.postgresql_15;
      enableTCPIP = true;
      authentication = pkgs.lib.mkOverride 10 ''
        local all all trust
        host all all ::1/128 trust
      '';
      ensureUsers = [
        {
          name = "sandhose";
          ensureClauses.superuser = true;
        }
      ];
    };

    # printing = {
    #   enable = true;
    #   drivers = with pkgs; [
    #     gutenprint
    #     gutenprintBin
    #     carps-cups
    #     # canon-cups-ufr2 # Broken
    #     cups-bjnp
    #     cnijfilter2
    #   ];
    # };
  };

  boot.plymouth = {
    enable = true;
  };

  environment.systemPackages = [
    pkgs.openrgb
    pkgs.wireshark
    # pkgs.teamviewer
    # pkgs.authy
    pkgs.qt5.qtwayland
    pkgs.qgnomeplatform
    # pkgs.lutris
  ];

  programs.gamescope = {
    enable = true;
    #capSysNice = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    gamescopeSession.enable = true;
  };

  systemd.services.steam-gamescope-session = {
    description = "Steam Gamescope Session";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.gamescope}/bin/gamescope -e  -h 2160 -w 3840 -- ${pkgs.steam}/bin/steam  -tenfoot -steamos -fulldesktopres";
      Restart = "always";
      User = "sandhose";
    };
  };

  # boot.loader.systemd-boot.extraEntries = {
  #   "steam-gamescope.conf" = ''
  #     title NixOS - Steam Gamescope Session
  #     sort-key steam-gamescope
  #     version Generation ${config.system.nixos.label} (Linux ${config.boot.kernelPackages.kernel.version})
  #     linux /EFI/nixos/${config.system}
  #     initrd /EFI/nixos/${config.system.build.initialRamdisk.efiFile}
  #     options init=${config.system.build.toplevel}/init systemd.unit=steam-gamescope-session.service pcie_aspm=off amd_iommu=on acpi_enforce_resources=lax nohibernate splash loglevel=4 audit=1 apparmor=1 security=apparmor
  #     machine-id ${config.networking.hostId}
  #   '';
  # };

  programs.wireshark.enable = true;

  hardware = {
    steam-hardware.enable = true;
    graphics = {
      enable32Bit = true;
      extraPackages = with pkgs; [
        libva
        vaapiVdpau
        libvdpau-va-gl
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        libva
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
  };
}
