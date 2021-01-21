{ config, pkgs, lib, ... }:

{
  programs = {
    neovim = {
      enable = true;
      vimAlias = true;

      extraConfig = (builtins.readFile ./vimrc);

      plugins = with pkgs.vimPlugins; [
        undotree
        nerdtree
        nerdtree-git-plugin
        vim-fugitive
        vim-gitgutter
        vim-surround
        vim-easy-align
        editorconfig-vim

        coc-nvim
        coc-git
        coc-highlight
        coc-html
        coc-json
        coc-snippets
        coc-tsserver
        coc-tslint-plugin
        coc-prettier
        coc-css
        # coc-pyright
        coc-yank
        coc-jest
        coc-eslint
        coc-lists
        coc-yaml
        coc-stylelint
        coc-git
        coc-rust-analyzer
        coc-explorer

        lightline-vim

        ultisnips
        vim-snippets
        base16-vim
        vim-polyglot
        vim-jsonnet
        goyo-vim
        limelight-vim
      ];
    };
  };

  home = {
    file.".config/nvim/coc-settings.json".text = builtins.toJSON {
      rust-analyzer = {
        serverPath = "${pkgs.rust-analyzer}/bin/rust-analyzer";
        procMacro.enable = true;
        cargo.loadOutDirsFromCheck = true;
      };
      languageserver = {
        golang = {
          command = "${pkgs.gopls}/bin/gopls";
          rootPatterns = [ "go.mod" ".vim/" ".git/" ];
          filetypes = [ "go" ];
          disableWorkspaceFolders = true;
          initializationOptions = { completeUnimported = true; };
        };
      };
      python = {
        jediEnabled = false;
        pipenvPath = "${pkgs.pipenv}/bin/pipenv";
        poetryPath = "${pkgs.python38Packages.poetry}/bin/poetry";
        linting.pylintPath = "${pkgs.python38Packages.pylint}/bin/pylint";
        linting.pylamaPath = "${pkgs.python39Packages.pylama}/bin/pylama";
        linting.pydocstylePath =
          "${pkgs.python39Packages.pydocstyle}/bin/pydocstyle";
        # linting.prospector = "${pkgs.prospector}/bin/prospector";
        linting.pep8Path = "${pkgs.python39Packages.pep8}/bin/pep8";
        linting.mypyPath = "${pkgs.python39Packages.mypy}/bin/mypy";
        linting.banditPath = "${pkgs.python39Packages.bandit}/bin/bandit";
        linting.flake8Path = "${pkgs.python39Packages.flake8}/bin/flake8";
        formatting.autopep8Path =
          "${pkgs.python39Packages.autopep8}/bin/autopep8";
        formatting.black = "${pkgs.python39Packages.black}/bin/black";
      };
      yaml = {
        schemas = {
          "https://json.schemastore.org/kustomization" = "kustomization.yaml";
          "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json" =
            "docker-compose.yaml";
        };
      };
      coc = {
        preferences = {
          formatOnSaveFiletypes = [
            "css"
            "markdown"
            "yaml"
            "rust"
            "javascript"
            "javascriptreact"
            "typescript"
            "json"
            "graphql"
          ];
        };
      };
    };
  };
}
