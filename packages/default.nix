{ nixpkgs }:

{
  fork-awesome = import ./fork-awesome.nix nixpkgs;
  virgil = import ./virgil.nix nixpkgs;
  neomutt = import ./neomutt.nix nixpkgs;
  utils = import ./utils.nix nixpkgs;
  jj-mark-reviewed = import ./jj-mark-reviewed.nix nixpkgs;
  zsh-funcs = import ./zsh-funcs nixpkgs;
  nvim-base16 = import ./nvim-base16.nix nixpkgs;
  material-nvim = import ./material-nvim.nix nixpkgs;
}
