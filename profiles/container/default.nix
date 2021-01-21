{ inputs, ... }:

with inputs; {
  imports = [ 
    home-manager.nixosModules.home-manager
    ../home-manager
    ../../users/root/nixos.nix
  ];

  nixpkgs.overlays = [ self.overlay nur.overlay ];
  nix.registry.nixpkgs.flake = nixpkgs;

  boot.isContainer = true;
  system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
  networking.useDHCP = false;

  # TODO: refactor this
  programs.zsh.enable = true;
}
