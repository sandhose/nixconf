{ stdenv, ... }:

stdenv.mkDerivation {
  name = "zsh-funcs";
  src = ./funcs;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/zsh/site-functions/
    install -m 755 manydots-magic $out/share/zsh/site-functions/
  '';
}
