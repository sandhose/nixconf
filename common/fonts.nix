{ pkgs, lib, ... }:

lib.mkMerge [
  {
    fonts.fonts = with pkgs; [
      fira-code
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

  (lib.mkIf pkgs.stdenv.isLinux {
    fonts.fontDir.enable = true;
  })

  (lib.mkIf pkgs.stdenv.isDarwin {
    fonts.enableFontDir = true;
  })
]
