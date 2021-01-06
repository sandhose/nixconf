{ config, pkgs, lib, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.sandhose = { pkgs, ... }: {
    imports = [ 
      ./modules/alacritty
      ./modules/npm
      ./modules/vim
      ./modules/tmux
      ./modules/zsh
      ./modules/git
      ./modules/firefox
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
      direnv = {
        enable = true;
        enableNixDirenvIntegration = true;
      };
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
