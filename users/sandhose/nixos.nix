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
