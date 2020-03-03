(self: super: {
    neomutt = super.neomutt.overrideAttrs (attrs: attrs // {
      buildInputs = (builtins.filter (n: n != super.ncurses) attrs.buildInputs) ++ [super.slang];
      configureFlags = attrs.configureFlags ++ ["--with-ui=slang"];
    });
})
