{ pkgs, ... }:

{
  services = {
    teamviewer.enable = true;
    flatpak.enable = true;
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      displayManager.gdm.wayland = true;
      desktopManager.gnome.enable = true;
      libinput.enable = true;
      layout = "fr";
      xkbModel = "pc105";
      xkbVariant = "mac";
    };

    postgresql = {
      enable = true;
      package = pkgs.postgresql_13;
      enableTCPIP = true;
      authentication = pkgs.lib.mkOverride 10 ''
        local all all trust
        host all all ::1/128 trust
      '';
      ensureUsers = [
        {
          name = "sandhose";
          ensurePermissions = {
            "ALL TABLES IN SCHEMA public" = "ALL PRIVILEGES";
          };
        }
      ];
    };

    printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
        gutenprintBin
        carps-cups
        # canon-cups-ufr2 # Broken
        cups-bjnp
        cnijfilter2
      ];
    };
  };

  services.gnome.experimental-features.realtime-scheduling = true;

  boot.plymouth = {
    enable = true;
  };

  environment.systemPackages = [ pkgs.openrgb pkgs.wireshark pkgs.teamviewer pkgs.authy pkgs.qt5.qtwayland pkgs.qgnomeplatform ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  programs.wireshark.enable = true;

  hardware = {
    steam-hardware.enable = true;
    opengl = {
      driSupport32Bit = true;
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
      setLdLibraryPath = true;
    };
  };
}
