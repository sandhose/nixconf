{ pkgs, ... }:

{
  gtk = {
    enable = pkgs.stdenv.isLinux;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    theme.name = "Adwaita-dark";
  };
}
