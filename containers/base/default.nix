{ inputs, ... }:

with inputs; {
  boot.isContainer = true;
  system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
  networking.useDHCP = false;
}
