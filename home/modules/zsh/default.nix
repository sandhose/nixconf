{ pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;

      autocd = true;
      defaultKeymap = "emacs";

      history = {
        extended = true;
        save = 10000;
        size = 10000;
        share = true;
        expireDuplicatesFirst = true;
      };

      shellAliases = {
        zmv = "noglob zmv -W";
        dr = "docker run -it --rm";
      };

      plugins = [{
        name = "base16-shell";
        src = pkgs.fetchFromGitHub {
          owner = "chriskempson";
          repo = "base16-shell";
          rev = "ce8e1e5";
          sha256 = "1yj36k64zz65lxh28bb5rb5skwlinixxz6qwkwaf845ajvm45j1q";
        };
      }];

      initExtra = builtins.readFile ./additional.zsh;
    };
  };
}
