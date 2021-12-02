{ pkgs, lib, inputs, ... }:

let inherit (inputs) nixpkgs;
in {
  imports = [
    "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
    ../../profiles/base
  ];

  boot.initrd.supportedFilesystems = [ "zfs" ]; # boot from zfs
  boot.supportedFilesystems = [ "zfs" ];

  networking = { hostName = "live"; };

  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
  users.users.root.openssh.authorizedKeys.keys = [
    "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBACiw9P5PHkzD7MuyUFr51A4OGf8IipB/vEmlgdE2zJeYKD+9zaaEEyZ8LxYFn7RMUEtD0043DJKzjGKR+8n7PucNgF3bGRkuDsaq3T7P2+zaj6jbnGYwm0q+4ltNzuO0gFWUhN399KXn2zZmHqh2SIdnkKOMQwdEl7lD0EAUcM76AQl3w== sandhose-desktop"
  ];
}
