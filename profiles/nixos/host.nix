{ pkgs, config, ... }:

{
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  security = {
    apparmor.enable = true;
    auditd.enable = true;
  };

  services = {
    openssh.enable = true;
    fwupd.enable = true;
    resolved = {
      enable = true;
      dnssec = "false";
    };
  };

  console.useXkbConfig = true;
}
