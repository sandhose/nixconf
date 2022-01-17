{ pkgs, lib, inputs, ... }:

let inherit (inputs) nixpkgs;

in
lib.mkMerge [
  {
    nix = {
      package = pkgs.nix;
      nixPath = [ "nixpkgs=${nixpkgs}" ];

      extraOptions = ''
        experimental-features = nix-command flakes
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
    nix.extraOptions = ''
      extra-platforms = aarch64-darwin x86_64-darwin
    '';
  })
]
