{ nixpkgs }:

{
  fork-awesome = import ./fork-awesome.nix nixpkgs;
  virgil = import ./virgil.nix nixpkgs;
  neomutt = import ./neomutt.nix nixpkgs;
  utils = import ./utils.nix nixpkgs;
  zsh-funcs = import ./zsh-funcs nixpkgs;
  nvim-base16 = import ./nvim-base16.nix nixpkgs;
  material-nvim = import ./material-nvim.nix nixpkgs;
  s3cmd = import ./s3cmd.nix nixpkgs;
}
