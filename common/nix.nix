{ pkgs, lib, ... }:

lib.mkMerge [
  {
    nix = {
      useSandbox = true;
      package = pkgs.nixFlakes;

      extraOptions = ''
        experimental-features = nix-command flakes
        keep-outputs = true
        keep-derivations = true
      '';
    };
  }

  (lib.mkIf pkgs.stdenv.isLinux {
    nix.trustedUsers = [ "@admin" ];
  })

  (lib.mkIf pkgs.stdenv.isDarwin {
    nix.trustedUsers = [ "@wheel" ];
  })
]
