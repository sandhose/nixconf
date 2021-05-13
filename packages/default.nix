{ nixpkgs }:

{
  fork-awesome = import ./fork-awesome.nix nixpkgs;
  virgil = import ./virgil.nix nixpkgs;
  neomutt = import ./neomutt.nix nixpkgs;
  cachix = import ./cachix.nix nixpkgs;
  utils = import ./utils.nix nixpkgs;
  zsh-funcs = import ./zsh-funcs nixpkgs;
}
