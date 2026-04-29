{ pkgs, ... }:

{
  imports = [ ./common.nix ];

  system.primaryUser = "quenting";

  users.users = {
    quenting = {
      home = "/Users/quenting";
    };
  };

  home-manager.users.quenting =
    { ... }:
    {
      imports = [
        # ../../profiles/home-manager/alacritty
        ../../profiles/home-manager/darwin-fonts
      ];
    };
}
