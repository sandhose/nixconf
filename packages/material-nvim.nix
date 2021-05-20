{ stdenv, fetchFromGitHub, ... }:

stdenv.mkDerivation rec {
  name = "nvim-base16";
  src = fetchFromGitHub {
    owner = "marko-cerovac";
    repo = "material.nvim";
    rev = "582c4634438d7601725715e6aba3c34fbaaf170f";
    hash = "sha256-GJhNDXlaVGMRnNAceH7uGDoeSvwFbIlTLcBALC7CzVQ=";
  };

  installPhase = ''
    mkdir -p $out/share/vim-plugins/material.nvim
    cp -r $src/* $out/share/vim-plugins/material.nvim/
  '';
}
