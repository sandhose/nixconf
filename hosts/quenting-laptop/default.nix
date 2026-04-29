{ ... }:

{
  imports = [
    ../../profiles/base
    ../../profiles/common
    ../../profiles/home-manager
    ../../profiles/darwin
    ../../users/quenting/darwin.nix
  ];

  system.stateVersion = 6;
}
