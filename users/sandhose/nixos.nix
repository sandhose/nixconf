{ ... }:

{
  imports = [ ./common.nix ];

  users = {
    groups.sandhose = { };
    users.sandhose = {
      isNormalUser = true;
      group = "sandhose";
      home = "/home/sandhose";
      extraGroups = [ "wheel" "docker" "libvirtd" "kvm" "dialout" ];

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKI3JrkOofavtPW8jV/GYM5Mv1gn/h732JPm82SGGj50 sandhose@sandhose-laptop"
      ];
    };
  };

  home-manager.users.sandhose = { ... }: {
    imports = [
      ../../profiles/home-manager/alacritty
      ../../profiles/home-manager/firefox
      ../../profiles/home-manager/gtk
      ../../profiles/home-manager/syncthing
    ];
  };
}
