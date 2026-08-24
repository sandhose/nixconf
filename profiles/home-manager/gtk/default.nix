{ config, pkgs, ... }:

{
  gtk = {
    enable = pkgs.stdenv.hostPlatform.isLinux;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.theme = config.gtk.theme;
    theme.name = "Adwaita-dark";
  };
}
