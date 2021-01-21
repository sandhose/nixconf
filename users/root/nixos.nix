{ pkgs, ... }:

{
  # Those directories don't seem to be created in containers
  # TODO: open an issue and/or move that somewhere else
  system.activationScripts.nix-per-user =
    ''
      install -d -m 755 /nix/var/nix/profiles/per-user/root
      install -d -m 755 /nix/var/nix/gcroots/per-user/root
    '';

  users.users.root = {
    shell = pkgs.zsh;
  };

  home-manager.users.root = { ... }: {
    imports = [
      ../../profiles/home-manager/direnv
      ../../profiles/home-manager/environment
      ../../profiles/home-manager/fzf
      ../../profiles/home-manager/git
      ../../profiles/home-manager/npm
      ../../profiles/home-manager/tmux
      ../../profiles/home-manager/vim
      ../../profiles/home-manager/zsh
    ];
  };
}
