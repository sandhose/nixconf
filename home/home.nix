{ pkgs, config, ...}:

{
  sessionVariables = {
    EDITOR          = "${pkgs.neovim}/bin/nvim";
    PAGER           = "${pkgs.less}/bin/less";
    LESS            = "-I -M -R --shift 5";
    PATH            = "$NPM_BIN:$HOME/go/bin:$HOME/.local/bin:$PATH";
    GIT_SSL_CAINFO  = "/run/current-system/etc/ssl/certs/ca-certificates.crt";
    FONTCONFIG_FILE = pkgs.makeFontsConf {
      fontDirectories = [
        "/Library/Fonts"
      ];
    };
  };

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
}
