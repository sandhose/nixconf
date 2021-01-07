{ pkgs, lib, ... }:


lib.mkMerge [
  {
    home.sessionVariables = {
      EDITOR          = "${pkgs.neovim}/bin/nvim";
      PAGER           = "${pkgs.less}/bin/less";
      LESS            = "-I -M -R --shift 5";
      PATH            = "$NPM_BIN:$HOME/go/bin:$HOME/.local/bin:$PATH";
      GIT_SSL_CAINFO  = "/run/current-system/etc/ssl/certs/ca-certificates.crt";
    };
  }
  (lib.mkIf pkgs.stdenv.isDarwin {
    home.sessionVariables = {
      FONTCONFIG_FILE = pkgs.makeFontsConf {
        fontDirectories = [
          "/Library/Fonts"
        ];
      };
    };
  })
]
