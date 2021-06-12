{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_5_12;
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  security = {
    apparmor.enable = true;
    auditd.enable = true;
  };

  services = {
    openssh.enable = true;
    fwupd.enable = true;
    resolved.enable = true;
  };

  console.useXkbConfig = true;
}
