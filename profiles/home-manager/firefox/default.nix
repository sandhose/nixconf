{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    extensions = with pkgs.firefox-addons; [
      ublock-origin
      reddit-enhancement-suite
      react-devtools
      https-everywhere
      languagetool
      keepassxc-browser
      i-dont-care-about-cookies
      facebook-container
    ];

    profiles = { default = { id = 0; }; };
  };
}
