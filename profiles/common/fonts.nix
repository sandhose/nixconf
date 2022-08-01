{ pkgs, ... }:

{
  fonts.fontDir.enable = true;
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
    # corefonts # Broken on darwin
    merriweather
    open-sans
    raleway
    cascadia-code
    my.fork-awesome
    my.virgil
  ];
}
