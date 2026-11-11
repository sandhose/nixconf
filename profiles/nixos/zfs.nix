{ ... }:

{
  boot.supportedFilesystems = [ "zfs" ];
  # boot.zfs.enableUnstable = true;
  boot.zfs.forceImportRoot = false;

  services.zfs = {
    autoSnapshot.enable = true;
    trim.enable = true;
    autoScrub.enable = true;
  };
}
