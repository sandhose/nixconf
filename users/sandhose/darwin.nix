{ pkgs, ... }:

{
  imports = [ ./common.nix ];

  system.primaryUser = "sandhose";

  users.users = {
    sandhose = {
      home = "/Users/sandhose";
    };
  };

  home-manager.users.sandhose =
    { ... }:
    {
      imports = [
        # ../../profiles/home-manager/alacritty
        ../../profiles/home-manager/darwin-fonts
      ];
    };
}
