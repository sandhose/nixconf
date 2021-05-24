{ config, pkgs, lib, ... }:

let
  pluginWithDeps = plugin: deps: plugin.overrideAttrs (_: { dependencies = deps; });
  nvimHome = "${config.xdg.configHome}/nvim";
in
{
  programs = {
    neovim = {
      enable = true;
      vimAlias = true;
      package = pkgs.neovim;

      extraPackages = with pkgs; [
        gcc
        tree-sitter

        # Needed by Telescope
        bat
        fd
        ripgrep

        # Various language servers
        rust-analyzer
        nodePackages.bash-language-server
        clang-tools
        nodePackages.vscode-css-languageserver-bin
        nodePackages.dockerfile-language-server-nodejs
        gopls
        nodePackages.vscode-html-languageserver-bin
        nodePackages.pyright
        rnix-lsp
        terraform-ls
      ];

      # Can't rely on init.lua, because it gets loaded before init.vim and
      # home-manager sets things like runtimepath and packpath in it
      # TODO: make that use ~/.local/share/nvim instead
      extraConfig = ''
        set backupdir=${nvimHome}/backups
        set directory=${nvimHome}/swaps
        set undodir=${nvimHome}/undo
        set shadafile=${nvimHome}/viminfo

        lua require'my'
        runtime config.vim
      '';

      plugins = with pkgs.vimPlugins;
        let
          fixGrammar = p: p.overrideAttrs (oldAttrs: rec {
            buildPhase = ''
              runHook preBuild
              scanner_cc="$src/src/scanner.cc"
              if [ ! -f "$scanner_cc" ]; then
                scanner_cc=""
              fi
              scanner_c="$src/src/scanner.c"
              if [ ! -f "$scanner_c" ]; then
                scanner_c=""
              fi
              $CXX -I$src/src/ -shared -o parser -Os $src/src/parser.c $scanner_cc $scanner_c -lstdc++
              runHook postBuild
            '';
          });
          telescope =
            (pluginWithDeps telescope-nvim [ plenary-nvim popup-nvim ]);
        in
          [
            pkgs.my.material-nvim # Color scheme
            undotree
            vim-fugitive
            vim-surround
            vim-easy-align
            editorconfig-vim

            plenary-nvim
            popup-nvim
            telescope

            nvim-lspconfig
            (
              nvim-treesitter.withPlugins (
                p: [
                  # TODO: package tree-sitter-comment
                  (fixGrammar p.tree-sitter-bash)
                  p.tree-sitter-c
                  (fixGrammar p.tree-sitter-cpp)
                  p.tree-sitter-css
                  p.tree-sitter-go
                  (fixGrammar p.tree-sitter-html)
                  p.tree-sitter-java
                  p.tree-sitter-javascript
                  p.tree-sitter-jsdoc
                  p.tree-sitter-json
                  # (p.tree-sitter-lua.overrideAttrs (_: {
                  #   patches = [ ./tree-sitter-lua.patch ];
                  # }))
                  (fixGrammar p.tree-sitter-markdown)
                  p.tree-sitter-nix
                  (fixGrammar p.tree-sitter-php)
                  (fixGrammar p.tree-sitter-python)
                  p.tree-sitter-regex
                  (fixGrammar p.tree-sitter-ruby)
                  p.tree-sitter-rust
                  p.tree-sitter-tsx
                  p.tree-sitter-typescript
                  (fixGrammar p.tree-sitter-yaml)
                ]
              )
            )
            nvim-web-devicons
            (pluginWithDeps nvim-tree-lua [ nvim-web-devicons ])
            (pluginWithDeps gitsigns-nvim [ plenary-nvim ])
            (pluginWithDeps rust-tools-nvim [ telescope nvim-lspconfig ])
            (pluginWithDeps telescope-symbols-nvim [ telescope ])
            nvim-compe
            lsp-status-nvim
            vim-vsnip
            vim-vsnip-integ
            friendly-snippets
            lspkind-nvim
            galaxyline-nvim

            # lightline-vim

            vim-polyglot
            vim-jsonnet
            goyo-vim
          ];
    };
  };

  home.file =
    let
      # Symlink everything in ./config to ~/.config/nvim/
      cfg = builtins.listToAttrs (
        map (
          file: {
            name = "${nvimHome}/${file}";
            value = {
              source = ./config + "/${file}";
              recursive = true;
            };
          }
        ) (builtins.attrNames (builtins.readDir ./config))
      );
    in
      cfg // {
        "${nvimHome}/undo/.keep".text = "";
        "${nvimHome}/swaps/.keep".text = "";
        "${nvimHome}/backups/.keep".text = "";
      };
}
