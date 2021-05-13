{ config, pkgs, lib, ... }:

{
  programs = {
    neovim = {
      enable = true;
      vimAlias = true;
      package = pkgs.neovim;

      extraConfig = builtins.replaceStrings [
        "RUST-ANALYZER"
        "BASH-LANGUAGE-SERVER"
        "CLANGD"
        "CSS-LANGUAGESERVER"
        "DOCKER-LANGSERVER"
        "GOPLS"
        "HTML-LANGUAGESERVER"
        "PYRIGHT-LANGSERVER"
        "RNIX-LSP"
        "TERRAFORM-LS"
      ] [
        "${pkgs.fenix.rust-analyzer}/bin/rust-analyzer"
        "${pkgs.nodePackages.bash-language-server}/bin/bash-language-server"
        "${pkgs.clang-tools}/bin/clangd"
        "${pkgs.nodePackages.vscode-css-languageserver-bin}/bin/css-languageserver"
        "${pkgs.nodePackages.dockerfile-language-server-nodejs}/bin/docker-langserver"
        "${pkgs.gopls}/bin/gopls"
        "${pkgs.nodePackages.vscode-html-languageserver-bin}/bin/html-languageserver"
        "${pkgs.nodePackages.pyright}/bin/pyright-langserver"
        "${pkgs.rnix-lsp}/bin/rnix-lsp"
        "${pkgs.terraform-ls}/bin/terraform-ls"
      ] (builtins.readFile ./vimrc);

      plugins = with pkgs.vimPlugins; [
        undotree
        # nerdtree
        # nerdtree-git-plugin
        vim-fugitive
        # vim-gitgutter
        vim-surround
        vim-easy-align
        editorconfig-vim

        # coc-nvim
        # coc-git
        # coc-highlight
        # coc-html
        # coc-json
        # coc-snippets
        # coc-tsserver
        # coc-tslint-plugin
        # coc-prettier
        # coc-css
        # coc-pyright
        # coc-yank
        # coc-jest
        # coc-eslint
        # coc-lists
        # coc-yaml
        # coc-stylelint
        # coc-git
        # coc-explorer

        plenary-nvim
        popup-nvim
        telescope-nvim
        nvim-lspconfig
        nvim-treesitter
        nvim-web-devicons
        nvim-tree-lua
        gitsigns-nvim
        # snippets-nvim
        rust-tools-nvim
        nvim-compe
        lsp-status-nvim
        vim-vsnip
        vim-vsnip-integ
        friendly-snippets

        lightline-vim

        # ultisnips
        vim-snippets
        base16-vim
        vim-polyglot
        vim-jsonnet
        goyo-vim
      ];
    };
  };

  home = {
    file."${config.xdg.configHome}/nvim/parser/bash.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-bash}/parser";
    file."${config.xdg.configHome}/nvim/parser/c.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-c}/parser";
    file."${config.xdg.configHome}/nvim/parser/cpp.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-cpp}/parser";
    file."${config.xdg.configHome}/nvim/parser/css.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-css}/parser";
    file."${config.xdg.configHome}/nvim/parser/go.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-go}/parser";
    file."${config.xdg.configHome}/nvim/parser/html.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-html}/parser";
    file."${config.xdg.configHome}/nvim/parser/java.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-java}/parser";
    file."${config.xdg.configHome}/nvim/parser/javascript.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-javascript}/parser";
    file."${config.xdg.configHome}/nvim/parser/jsdoc.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-jsdoc}/parser";
    file."${config.xdg.configHome}/nvim/parser/json.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-json}/parser";
    # file."${config.xdg.configHome}/nvim/parser/lua.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-lua}/parser";
    file."${config.xdg.configHome}/nvim/parser/markdown.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-markdown}/parser";
    file."${config.xdg.configHome}/nvim/parser/nix.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-nix}/parser";
    file."${config.xdg.configHome}/nvim/parser/php.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-php}/parser";
    file."${config.xdg.configHome}/nvim/parser/python.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-python}/parser";
    file."${config.xdg.configHome}/nvim/parser/regex.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-regex}/parser";
    file."${config.xdg.configHome}/nvim/parser/ruby.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-ruby}/parser";
    file."${config.xdg.configHome}/nvim/parser/rust.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-rust}/parser";
    file."${config.xdg.configHome}/nvim/parser/tsx.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-tsx}/parser";
    file."${config.xdg.configHome}/nvim/parser/typescript.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-typescript}/parser";
    file."${config.xdg.configHome}/nvim/parser/yaml.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-yaml}/parser";
  };
}
