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
  };

  hardware = {
    steam-hardware.enable = true;
    opengl = {
      driSupport32Bit = true;
      extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    };
  };
}
