{ stdenv }:

stdenv.mkDerivation rec {
  name = "zsh-funcs";
  src = ./funcs;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/zsh/site-functions/
    install -m 755 venv $out/share/zsh/site-functions/
    install -m 755 color $out/share/zsh/site-functions/
    install -m 755 f $out/share/zsh/site-functions/
    install -m 755 b $out/share/zsh/site-functions/
    install -m 755 rationalise-dot $out/share/zsh/site-functions/
  '';
}
