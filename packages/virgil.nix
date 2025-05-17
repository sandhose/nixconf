{
  stdenv,
  fetchFromGitHub,
  woff2,
  ...
}:

stdenv.mkDerivation rec {
  name = "virgil";
  version = "0.0.0";
  src = fetchFromGitHub {
    owner = "excalidraw";
    repo = "virgil";
    rev = "55c9c6dd2f7a533d71718350e0b8299b4862c4a4";
    sha256 = "sha256-ApFWppwo1T0eU6Te2QXFmF0fV+SD18N1c+tiLUl2eeQ=";
  };

  buildInputs = [ woff2 ];

  installPhase = ''
    woff2_decompress Virgil.woff2
    mkdir -p $out/share/fonts/truetype
    cp Virgil.ttf $out/share/fonts/truetype/
  '';
}
