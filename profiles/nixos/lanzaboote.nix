{
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  # Add sbctl for managing secure boot keys
  environment.systemPackages = [ pkgs.sbctl ];

  # Disable systemd-boot - lanzaboote replaces it
  boot.loader.systemd-boot.enable = lib.mkForce false;

  # Enable lanzaboote for secure boot support
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  # Keep EFI variable modification enabled
  boot.loader.efi.canTouchEfiVariables = true;
}
