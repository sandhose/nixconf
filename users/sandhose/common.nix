{ pkgs, ... }:

{
  users = {
    users.sandhose = {
      description = "Quentin Gliech";
      shell = pkgs.zsh;

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKI3JrkOofavtPW8jV/GYM5Mv1gn/h732JPm82SGGj50 sandhose@sandhose-laptop"
      ];
    };
  };

  home-manager.users.sandhose = { ... }: {
    imports = [
      ../../profiles/home-manager/direnv
      ../../profiles/home-manager/environment
      ../../profiles/home-manager/fzf
      ../../profiles/home-manager/git
      ../../profiles/home-manager/git/sandhose.nix
      ../../profiles/home-manager/npm
      ../../profiles/home-manager/tmux
      ../../profiles/home-manager/vim
      ../../profiles/home-manager/zsh
    ];
  };
}
