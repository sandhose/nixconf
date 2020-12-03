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
        coc-python
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
          rootPatterns = ["go.mod" ".vim/" ".git/"];
          filetypes = ["go"];
          disableWorkspaceFolders = true;
          initializationOptions = {
            completeUnimported = true;
          };
        };
      };
      yaml = {
        schemas = {
          "https://json.schemastore.org/kustomization" = "kustomization.yaml";
          "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json" = "docker-compose.yaml";
        };
      };
      coc = {
        preferences = {
          formatOnSaveFiletypes = [
            "css" "markdown" "yaml" "rust" "javascript" "javascriptreact"
            "typescript" "json" "graphql"
          ];
        };
      };
    };
  };
}
