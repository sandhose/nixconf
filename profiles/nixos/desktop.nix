{ pkgs, ... }:

{
  services = {
    flatpak.enable = true;
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome3.enable = true;
      libinput.enable = true;
      layout = "fr";
      xkbModel = "pc105";
      xkbVariant = "mac";
    };

    postgresql = {
      enable = true;
      package = pkgs.postgresql_13;
      ensureUsers = [{
        name = "sandhose";
        ensurePermissions = {
          "ALL TABLES IN SCHEMA public" = "ALL PRIVILEGES";
        };
      }];
    };

    printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
        gutenprintBin
        canon-cups-ufr2
      ];
    };
  };

  environment.gnome3.excludePackages = with pkgs.gnome3; [
    cheese
  ];

  # programs.steam.enable = true;

  hardware = {
    steam-hardware.enable = true;
    opengl = {
      driSupport32Bit = true;
      extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
      setLdLibraryPath = true;
    };
  };
}
