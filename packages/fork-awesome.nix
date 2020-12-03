{ stdenv, fetchFromGitHub, ... }:

stdenv.mkDerivation rec {
  name = "fork-awesome";
  version = "1.1.7";
  src = fetchFromGitHub {
    owner = "ForkAwesome";
    repo = "Fork-Awesome";
    rev = version;
    sha256 = "15kpsp9qdmb41ykzrqc08b9jsi94lpknbyjzskxj0zic8f6fxpmp";
  };

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp -r fonts/*.ttf $out/share/fonts/truetype
  '';
}
