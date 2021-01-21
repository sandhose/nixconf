{ pkgs, ... }:

{
  home.sessionVariables = {
    FONTCONFIG_FILE =
      pkgs.makeFontsConf { fontDirectories = [ "/Library/Fonts" ]; };
  };
}
