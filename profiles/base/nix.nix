{ pkgs, lib, inputs, ... }:

let inherit (inputs) nixpkgs;

in
lib.mkMerge [
  {
    nix = {
      package = pkgs.nix;
      nixPath = [ "nixpkgs=${nixpkgs}" ];
      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        keep-outputs = true;
        keep-derivations = true;
      };
    };
  }

  (lib.mkIf pkgs.stdenv.isLinux {
    nix.settings = {
      sandbox = true;
      trusted-users = [ "@admin" ];
    };
  })

  (lib.mkIf pkgs.stdenv.isDarwin {
    nix.settings = {
      sandbox = false; # For some reason does not work on my laptop
      trusted-users = [ "@wheel" ];
      extra-platforms = [ "aarch64-darwin" "x86_64-darwin" ];
    };
  })
]
