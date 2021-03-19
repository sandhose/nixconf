{ lib, inputs, ... }:

let
  inherit (inputs) self home-manager nixpkgs;

in {
  imports = [
    nixpkgs.nixosModules.notDetected
    home-manager.nixosModules.home-manager
    ../home-manager
  ];

  fonts.fontDir.enable = true;
  time.timeZone = "Europe/Paris";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.09"; # Did you read the comment?

  system.configurationRevision = lib.mkIf (self ? rev) self.rev;
}
