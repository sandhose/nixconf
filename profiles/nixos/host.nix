{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;

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
