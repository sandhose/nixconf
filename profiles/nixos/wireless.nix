{ pkgs, ... }:

# Support for my wifi/bluetooth card combo
{
  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    bluetooth = {
      enable = true;
      package = pkgs.bluez;
      hsphfpd.enable = true;
    };
  };
}
