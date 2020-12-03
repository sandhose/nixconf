{ config, pkgs, lib, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.sandhose = { pkgs, ... }: {
    imports = [ 
      ./modules/npm
      ./modules/vim
      ./modules/tmux
      ./modules/zsh
      ./modules/git
    ];

    home = {
      sessionVariables = {
        EDITOR          = "${pkgs.neovim}/bin/nvim";
        PAGER           = "${pkgs.less}/bin/less";
        LESS            = "-I -M -R --shift 5";
        PATH            = "$NPM_BIN:$HOME/go/bin:$HOME/.local/bin:$PATH";
        GIT_SSL_CAINFO  = "/run/current-system/etc/ssl/certs/ca-certificates.crt";
        FONTCONFIG_FILE = pkgs.makeFontsConf {
          fontDirectories = [
            "/Library/Fonts"
          ];
        };
      };
    };

    programs = {
      fzf = {
        enable = true;
        historyWidgetOptions = [
          "--layout=reverse"
          "--inline-info"
        ];
      };
    };
  };
}
