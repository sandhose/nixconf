{ pkgs, ... }:

{
  services = {
    tailscale.enable = true;
    # teamviewer.enable = true;
    flatpak.enable = true;
    xserver = {
      enable = true;
      xkb = {
        model = "pc105";
        variant = "mac";
        layout = "fr";
      };
    };
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
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
    # The initrd only ships this one font, and the boot log view asks for
    # "monospace": give it an actual monospace font
    font = "${pkgs.nerd-fonts.fira-code}/share/fonts/truetype/NerdFonts/FiraCode/FiraCodeNerdFont-Regular.ttf";
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

  programs.nix-ld = {
    enable = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    gamescopeSession.enable = true;
  };

  programs.wireshark.enable = true;

  hardware = {
    steam-hardware.enable = true;
    graphics = {
      enable32Bit = true;
      extraPackages = with pkgs; [
        libva
        libva-vdpau-driver
        libvdpau-va-gl
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        libva
        libva-vdpau-driver
        libvdpau-va-gl
      ];
    };
    logitech.wireless.enable = true;
  };

  programs.solaar.enable = true;
}
