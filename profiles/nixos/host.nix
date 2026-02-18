{ pkgs, config, ... }:

{
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
      settings.Resolve.DNSSEC = "false";
    };
  };

  console.useXkbConfig = true;
}
