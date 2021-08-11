{ pkgs, ... }:

{
  gtk = {
    enable = pkgs.stdenv.isLinux;
    gtk3.extraConfig = { gtk-application-prefer-dark-theme = true; };
    theme.name = "Adwaita-dark";
  };

  qt = {
    enable = pkgs.stdenv.isLinux;
    platformTheme = "gnome";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };
}
