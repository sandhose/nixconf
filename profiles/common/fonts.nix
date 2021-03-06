{ pkgs, ... }:

{
  fonts.fonts = with pkgs; [
    fira-code
    nerdfonts
    roboto
    roboto-mono
    roboto-slab
    source-sans-pro
    source-code-pro
    source-serif-pro
    ibm-plex
    corefonts
    merriweather
    opensans-ttf
    raleway
    cascadia-code
    my.fork-awesome
    my.virgil
  ];
}
