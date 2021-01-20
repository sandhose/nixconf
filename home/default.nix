{ config, pkgs, lib, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.sandhose = { pkgs, ... }: {
    imports = [
      ./modules/alacritty
      ./modules/direnv
      ./modules/environment
      ./modules/firefox
      ./modules/fzf
      ./modules/git
      ./modules/gtk
      ./modules/npm
      ./modules/syncthing
      ./modules/tmux
      ./modules/vim
      ./modules/zsh
    ];
  };
}
