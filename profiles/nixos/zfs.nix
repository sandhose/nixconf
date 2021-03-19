{ ... }:

{
  boot.supportedFilesystems = [ "zfs" ];

  services.zfs = {
    autoSnapshot.enable = true;
    trim.enable = true;
    autoScrub.enable = true;
  };
}
