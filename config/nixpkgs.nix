{
  config = {
    packageOverrides = pkgs: {
      neomutt = pkgs.neomutt.overrideAttrs (attrs: attrs // {
        buildInputs = (builtins.filter (n: n != pkgs.ncurses) attrs.buildInputs) ++ [pkgs.slang];
        configureFlags = attrs.configureFlags ++ ["--with-ui=slang"];
      });

      fly = pkgs.callPackage ../packages/fly { };
    };

    allowUnsupportedSystem = true;
    allowUnfree = true;
  };
}
