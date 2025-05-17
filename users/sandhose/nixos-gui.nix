{ ... }:

{
  imports = [ ./nixos.nix ];

  home-manager.users.sandhose =
    { ... }:
    {
      imports = [
        ../../profiles/home-manager/alacritty
        #../../profiles/home-manager/kitty
        ../../profiles/home-manager/firefox
        ../../profiles/home-manager/gtk
        ../../profiles/home-manager/syncthing
      ];
    };
}
