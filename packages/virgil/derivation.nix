{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "virgil";
  version = "0.0.0";
  src = fetchFromGitHub {
    owner = "excalidraw";
    repo = "excalidraw";
    rev = "c06988a202a821088443ad13aa1faa35dc287b59";
    sha256 = "0n8sbsawbipslwigmd8dgmzr4m48sv32r2k9v2nip6ml991mxrs4";
  };

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp public/FG_Virgil.ttf $out/share/fonts/truetype/
  '';
}
