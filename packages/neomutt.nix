{ pkgs, ... }:

pkgs.neomutt.overrideAttrs (
  attrs:
  attrs
  // {
    buildInputs = (builtins.filter (n: n != pkgs.ncurses) attrs.buildInputs) ++ [ pkgs.slang ];
    configureFlags = attrs.configureFlags ++ [ "--with-ui=slang" ];
  }
)
