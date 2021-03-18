{ pkgs, ... }:

{
  users = {
    users.sandhose = {
      description = "Quentin Gliech";
      shell = pkgs.zsh;
    };
  };

  home-manager.users.sandhose = { ... }: {
    home.stateVersion = "20.03";
    imports = [
      ../../profiles/home-manager/direnv
      ../../profiles/home-manager/environment
      ../../profiles/home-manager/fzf
      ../../profiles/home-manager/git
      ../../profiles/home-manager/git/sandhose.nix
      ../../profiles/home-manager/nix
      ../../profiles/home-manager/npm
      ../../profiles/home-manager/tmux
      ../../profiles/home-manager/vim
      ../../profiles/home-manager/zsh
    ];
  };
}
