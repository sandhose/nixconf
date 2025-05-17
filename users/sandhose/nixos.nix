{ ... }:

{
  imports = [ ./common.nix ];

  users = {
    groups.sandhose = { };
    users.sandhose = {
      isNormalUser = true;
      group = "sandhose";
      home = "/home/sandhose";
      extraGroups = [
        "wheel"
        "docker"
        "libvirtd"
        "kvm"
        "dialout"
        "audio"
        "wireshark"
      ];

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKI3JrkOofavtPW8jV/GYM5Mv1gn/h732JPm82SGGj50 sandhose@sandhose-laptop"
        "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBACiw9P5PHkzD7MuyUFr51A4OGf8IipB/vEmlgdE2zJeYKD+9zaaEEyZ8LxYFn7RMUEtD0043DJKzjGKR+8n7PucNgF3bGRkuDsaq3T7P2+zaj6jbnGYwm0q+4ltNzuO0gFWUhN399KXn2zZmHqh2SIdnkKOMQwdEl7lD0EAUcM76AQl3w== sandhose-desktop"
        "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBP84fwAsjyX4ziJvQ4HZesaVRbvhQvCEYPfKBNBSCWHsnnDQn4o85HAdKceVwcNN/wlfm+AuH9pNpoJgpEEfpy4= sandhose@Quentins-MacBook-Pro.local"
      ];
    };
  };

  home-manager.users.sandhose =
    { ... }:
    {
      imports = [ ../../profiles/home-manager/cargo/nixos.nix ];
    };
}
