{ pkgs, lib, ... }:

lib.mkMerge [
  {
    nix = {
      package = pkgs.nixUnstable;

      extraOptions = ''
        experimental-features = nix-command flakes ca-references
        keep-outputs = true
        keep-derivations = true
      '';
    };
  }

  (lib.mkIf pkgs.stdenv.isLinux {
    nix.useSandbox = true;
    nix.trustedUsers = [ "@admin" ];
  })

  (lib.mkIf pkgs.stdenv.isDarwin {
    nix.useSandbox = false; # For some reason does not work on my laptop
    nix.trustedUsers = [ "@wheel" ];
  })
]
