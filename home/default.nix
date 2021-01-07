{ config, pkgs, lib, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.sandhose = { pkgs, ... }: {
    imports = [ 
      ./modules/alacritty
      ./modules/direnv
      ./modules/firefox
      ./modules/fzf
      ./modules/git
      ./modules/npm
      ./modules/syncthing
      ./modules/tmux
      ./modules/vim
      ./modules/zsh
    ];

    home = {
      sessionVariables = {
        EDITOR          = "${pkgs.neovim}/bin/nvim";
        PAGER           = "${pkgs.less}/bin/less";
        LESS            = "-I -M -R --shift 5";
        PATH            = "$NPM_BIN:$HOME/go/bin:$HOME/.local/bin:$PATH";
        GIT_SSL_CAINFO  = "/run/current-system/etc/ssl/certs/ca-certificates.crt";
      } // lib.mkIf (pkgs.stdenv.isDarwin) {
        FONTCONFIG_FILE = pkgs.makeFontsConf {
          fontDirectories = [
            "/Library/Fonts"
          ];
        };
      };
    };
  };
}
