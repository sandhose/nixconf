{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    profiles.default = {
      id = 0;
      settings = { "gfx.webrender.all" = true; };

      extensions = with pkgs.firefox-addons; [
        ublock-origin
        reddit-enhancement-suite
        react-devtools
        languagetool
        keepassxc-browser
        i-dont-care-about-cookies
        facebook-container
      ];
    };
  };

  systemd.user.sessionVariables = { MOZ_ENABLE_WAYLAND = 1; };
}
