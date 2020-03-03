(self: super: {
  nodePackages = super.nodePackages // {
    graphql-lsp = (import ../packages/graphql-lsp {
      pkgs = super;
      nodejs = super.nodejs;
    }).package;
  };
})
