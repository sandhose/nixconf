{ ... }:

{
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.enableUnstable = true;

  services.zfs = {
    autoSnapshot.enable = true;
    trim.enable = true;
    autoScrub.enable = true;
  };
}
