{ lib, inputs, pkgs, ... }:

let inherit (inputs) self home-manager nixpkgs dwarffs;

in
{
  imports = [
    nixpkgs.nixosModules.notDetected
    home-manager.nixosModules.home-manager
    dwarffs.nixosModules.dwarffs
    ../home-manager
  ];

  nix.package = lib.mkForce pkgs.nix;

  # TODO: move this elsewhere and ensure emoji always go first
  fonts.fontconfig = {
    enable = true;
    defaultFonts.monospace = [ "FiraCode Nerd Font" "Noto Color Emoji" ];
  };
  time.timeZone = "Europe/Paris";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "21.05"; # Did you read the comment?

  system.configurationRevision = lib.mkIf (self ? rev) self.rev;
}
