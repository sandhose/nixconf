{ pkgs, config, ... }:

{ 
  nixpkgs.config = {
    packageOverrides = pkgs: {
      neomutt = pkgs.neomutt.overrideAttrs (attrs: attrs // {
        buildInputs = (builtins.filter (n: n != pkgs.ncurses) attrs.buildInputs) ++ [pkgs.slang];
        configureFlags = attrs.configureFlags ++ ["--with-ui=slang"];
      });

      fly = pkgs.callPackage ../packages/fly { };
      zsh-funcs = pkgs.callPackage ../packages/zsh-funcs { };
    };

    allowUnsupportedSystem = true;
    allowUnfree = true;
  };
}
