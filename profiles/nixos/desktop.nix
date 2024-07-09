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
      ensureUsers = [{
        name = "sandhose";
        ensureClauses.superuser = true;
      }];
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

  boot.plymouth = { enable = true; };

  environment.systemPackages = [
    pkgs.openrgb
    pkgs.wireshark
    # pkgs.teamviewer
    # pkgs.authy
    pkgs.qt5.qtwayland
    pkgs.qgnomeplatform
    # pkgs.lutris
  ];

  # programs.steam = {
  #   enable = true;
  #   remotePlay.openFirewall = true;
  # };

  programs.wireshark.enable = true;

  hardware = {
    steam-hardware.enable = true;
    graphics = {
      enable32Bit = true;
      extraPackages = with pkgs; [ libva vaapiVdpau libvdpau-va-gl ];
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
