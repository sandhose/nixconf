{ stdenv, fetchFromGitHub, ... }:

stdenv.mkDerivation rec {
  name = "nvim-base16";
  src = fetchFromGitHub {
    owner = "RRethy";
    repo = "nvim-base16";
    rev = "1eef75abc5d8bb0bf0273b56ad20a3454ccbb27d";
    hash = "sha256-dejvGU+MSrMcPr1HNrLbFajUcNsIcYex7qmYWXLLNpg=";
  };

  installPhase = ''
    mkdir -p $out/share/vim-plugins/nvim-base16
    cp -r $src/* $out/share/vim-plugins/nvim-base16/
  '';
}
