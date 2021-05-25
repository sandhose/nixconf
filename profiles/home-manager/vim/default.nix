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
          fixGrammar = p: p.overrideAttrs (
            oldAttrs: rec {
              buildPhase = ''
                runHook preBuild
                objects=""
                scanner_cc="$src/src/scanner.cc"
                if [ -f "$scanner_cc" ]; then
                  $CXX -I$src/src/ "$scanner_cc" -c -o scanner_cc.o
                  objects="$objects scanner_cc.o"
                fi
                scanner_c="$src/src/scanner.c"
                if [ -f "$scanner_c" ]; then
                  $CC -I$src/src/ "$scanner_c" -c -o scanner_c.o
                  objects="$objects scanner_c.o"
                fi
                $CC -I$src/src/ -shared -o parser -Os $src/src/parser.c $objects -lstdc++
                runHook postBuild
              '';
            }
          );
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
                origGrammars: let
                  grammars = lib.mapAttrs (_: fixGrammar) origGrammars;
                in
                  [
                    # TODO: package tree-sitter-comment
                    grammars.tree-sitter-bash
                    grammars.tree-sitter-c
                    grammars.tree-sitter-cpp
                    grammars.tree-sitter-css
                    grammars.tree-sitter-go
                    grammars.tree-sitter-html
                    grammars.tree-sitter-java
                    grammars.tree-sitter-javascript
                    grammars.tree-sitter-jsdoc
                    grammars.tree-sitter-json
                    # (grammars.tree-sitter-lua.overrideAttrs (_: {
                    #   patches = [ ./tree-sitter-lua.patch ];
                    # }))
                    grammars.tree-sitter-markdown
                    grammars.tree-sitter-nix
                    grammars.tree-sitter-php
                    grammars.tree-sitter-python
                    grammars.tree-sitter-regex
                    grammars.tree-sitter-ruby
                    grammars.tree-sitter-rust
                    grammars.tree-sitter-tsx
                    grammars.tree-sitter-typescript
                    grammars.tree-sitter-yaml
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
